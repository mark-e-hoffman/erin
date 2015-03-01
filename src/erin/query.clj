(ns erin.query
  (:require [erin.database :as db])
  (:require [clojure.java.jdbc :as jdbc]))


(defn get-artists[]
  (jdbc/query db/pgdb ["select * from erin.artist"]))


(defn get-artist [ id ]
  (jdbc/query db/pgdb ["select * from erin.artist where id = ?" id]))
