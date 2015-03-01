(ns erin.crud
  (:require [erin.database :as db])
  (:require [clojure.java.jdbc :as jdbc]))


(defn get-all [ table ]
  (println (str table ",table:" (db/add-schema table)))
  (jdbc/query (db/pgdb) [(str "select * from " (db/add-schema table))]))


(defn search [ table params ]
  (println (str table "," params))
  (if (empty? params)
          (get-all table)
          (do
            (let [where-part (db/gen-where-from-params params )
                  values (vals params)
                  sql (str "select * from " (db/add-schema table) " where " where-part )]
              (println sql)
                (jdbc/query (db/pgdb) (concat [sql] values ))))))



(defn lookup [ table params ]
  (println (str table "," params))
  (let [
         col (:col params)
         val (:val params)
         id_col (:id_col params)
         display_cols (clojure.string/join  ", " (:display_cols params))
         where-part (db/gen-where-from-params { col val } " ilike ")
         sql (str "select concat_ws('/', " display_cols ") as value, " id_col " as data from " (db/add-schema table) " where " where-part)]
    (println sql)
   (jdbc/query (db/pgdb) [ sql (str "%" val "%")])))

(defn get-by-id [ table id ]
  (first (jdbc/query (db/pgdb) [(str "select * from " (db/add-schema table) " where id = ?") id])))

(defn create [ table body ]
  (jdbc/insert! (db/pgdb) (db/add-schema table ) (db/convert-dates-if-present body)))

(defn update [ table id body]
  (jdbc/update! (db/pgdb) (db/add-schema table ) (db/convert-dates-if-present body) ["id=?" id]))


(defn delete [ table id]
    "Not supported")

