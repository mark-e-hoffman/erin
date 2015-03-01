(ns erin.people
  (:require [erin.database :as db])
  (:require [clojure.java.jdbc :as jdbc]))


(defn get-people[ params ]
  (jdbc/query db/pgdb ["select * from erin.people"]))


(defn get-person [ id ]
  (first (jdbc/query db/pgdb ["select * from erin.people where id = ?" id])))

(defn add-person [ body ]
  (jdbc/insert! db/pgdb "erin.people" body))


(defn update-person [ id body ]
  (jdbc/update! db/pgdb "erin.people" body [ "id=?" (:id body)]))



