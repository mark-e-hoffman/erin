(ns erin.handler
(:use compojure.core)
  (:require [clj-time.core :as t])
  (:require [clj-time.format :as f])
  (:require [clj-time.local :as l])
  (:require [clj-yaml.core :as yaml])
  (:require [clojure.tools.logging :as log])

  (:require [compojure.handler :as handler]
          [compojure.route :as route]
          [erin.database :as db]
          [erin.crud :as crud ]
          [ring.adapter.jetty :as jetty]
          [ring.util.response :as resp]
          [ring.middleware.basic-authentication :refer [wrap-basic-authentication]]
          [ring.middleware.json :as json])
  (:gen-class))


(def ^:dynamic *yml-cfg* (atom {}))

(defn override-yml
  "Convert the list of keywords to a dotted string then attempt to find that property in the Java system properties"
  [ path ]
  (let [ key (apply str (interpose "." (map #(name %) path))) ]
    (System/getProperty key)))

(defn init-yml
  "Load the yaml file and produce a map of configuration values"
  [ file-name ]
  (swap! *yml-cfg* conj (yaml/parse-string (slurp file-name))))


(defn get-cfg-value
  "Lookup the configuration value by key(s), first checking to see if there were any command line overrides"
  [ path & def-val]
  (let [ override (override-yml path)]
    (if (nil? override)
      (get-in (deref *yml-cfg* ) path (first def-val))
      override)))


(defn- log [ msg & vals]
  (let [ line (apply format msg vals)]
    (log/info line )))


(defn authenticated? [name pass]
  (and (= name "foo")
       (= pass "bar")))

(defn wrap-request-logging [ handler]
  (fn [ {:keys [ request-method uri headers] :as req}]
    (let [ start (System/currentTimeMillis)
          resp (handler req)
          finish (System/currentTimeMillis)
          total (- finish start)]
      (log "%s|%s|%s|%s|(%dms)" (l/format-local-time (l/local-now) :basic-date-time) (clojure.string/upper-case (name request-method)) uri headers total)
      resp)))


(defn erin-get? [ request]
  (and
        (= (:request-method request) :get)
        (.startsWith (:uri request) "/v1/erin/")))


(defn wrap-empty-to-not-found [ handler ]
  (fn [ request ]
    (let [ response (handler request )]
      (if (and (erin-get? request )
               (empty? (:body response)))
                  {:status 404 :body "Not Found"}
          response))))


(defroutes app-routes
  (context "/erin" []
    (defroutes erin-routes
    (context "/:table" [ table ]
      (defroutes tables-routes
        (GET "/" request (resp/response (crud/search (keyword table) (dissoc (:params request) :table))))
        (POST "/" request (resp/response (crud/create (keyword table) (:body request))))
        (context "/lookup" []
                 (GET "/" request (resp/response (crud/lookup (keyword table) (:params request ) ))))
        (context "/:id" [id] (defroutes table-route
          (GET "/" [] (resp/response (crud/get-by-id (keyword table) id)))
          (PUT "/" request (resp/response (crud/update (keyword table) id (:body request))))
          (DELETE "/" [] (resp/response (crud/delete (keyword table) id)))))))))
  (route/resources "/")
  (route/not-found "Not Found"))

(defn init [ & cfg-file]
  (init-yml (if (empty? cfg-file) "config.yml" (first cfg-file)))
  (db/init-db get-cfg-value))

(defroutes v1-app-routes
  (context "/v1" []
           app-routes))
(def app
  (-> (handler/api v1-app-routes)
      (wrap-request-logging)
      (json/wrap-json-body {:keywords? true})
      (wrap-empty-to-not-found)
      (json/wrap-json-response)))

(defn -main [& [yml-file]]
  (init yml-file)
  (let [port (get-cfg-value [:http :port] 8080)]
    (jetty/run-jetty app {:port port})
    (log/info (str "You can view the site at http://localhost:" port))))

