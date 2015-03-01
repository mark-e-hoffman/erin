(ns erin.artists
  (:require [erin.database :as db])
  (:require [clojure.java.jdbc :as jdbc]))


(defn get-artists[params]
  (println (str "params:" params))
  (jdbc/query db/pgdb ["select * from erin.artist"]))


(defn get-artist [ id ]
  (first (jdbc/query db/pgdb ["select * from erin.artist where id = ?" id])))

(defn add-artist [ body ]
  (jdbc/insert! db/pgdb "erin.artist" body))

(defn update-artist [ id body]
  (println (str "id:" id ",body:" body)))

