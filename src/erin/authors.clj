(ns erin.authors
  (:require [erin.database :as db])
  (:require [clojure.java.jdbc :as jdbc]))


(defn get-authors[ params]
  (jdbc/query db/pgdb ["select * from erin.authors"]))


(defn get-author [ id ]
  (first (jdbc/query db/pgdb ["select * from erin.authors where id = ?" id])))


(defn add-author [ body ]
  (jdbc/insert! db/pgdb "erin.authors" body))

(defn update-author [ id body]
  (println (str "id:" id ",body:" body)))


