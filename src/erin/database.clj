(ns erin.database
  (:require [clojure.string])
  (:require [clj-time.core :as t])
  (:require [clj-time.format :as f])
  (:require [clj-time.coerce :as c])
  (:require [clojure.java.jdbc :as jdbc]))

(def _pgdb
  { :subprotocol "postgresql"
   :subname "//localhost:5432/erindb" })

(def multi-parser (f/formatter (t/default-time-zone) "YYYY-MM-dd" "YYYY-MM-dd HH:mm:ss" "YYYY-MM-dd'T'HH:mm:ssZ"))


(def _erindb-meta-data
  { :schema "erin"
   :tables {:artists "artist"
             :people "people"
             :authors "authors"
             :entities "entity"
             :characters "characters"
             :photos "photos"}
   })

(def ^{:dynamic true} *pgdb* (ref nil))
(def ^{:dynamic true} *erindb-meta-data* (ref nil))



(defn pgdb [] (deref *pgdb*))

(defn erindb-meta-data [] (deref *erindb-meta-data*))


(defn mk-sql-type-lookup [ p ]
  { (keyword (:column_name p)) (keyword (:udt_name p))})


(defn get-column-type-info
  "create a map of column-name to data-type. Both key and value are keywords
e.g { :id :varchar }"

  [ table ]
  { table (into {} (mapcat #(mk-sql-type-lookup % )
                           (jdbc/query (pgdb)
                                       [ "select column_name,udt_name from information_schema.columns where table_schema = ? and table_name = ?"
                                        (:schema erindb-meta-data)
                                        (get-in (erindb-meta-data) [:tables table])])))})

(defn get-columns-type-info
  "create a nested map of tables with column-type info"
  [ ]
  (into {} (mapcat #(get-column-type-info % ) (keys (:tables (erindb-meta-data))))))


(defn init-db [ cfg-fn ]
  (dosync  (ref-set *erindb-meta-data* (cfg-fn [:database :meta-data ])))
  (dosync  (ref-set *pgdb* (cfg-fn [:database :jdbc-driver ]))))



  ;; redefine erindb meta data with the column info


(defn add-schema [ table ]
  (str (:schema (erindb-meta-data)) "." (get-in (erindb-meta-data) [:tables table])))



(def dt-parser (partial f/parse multi-parser))

(defn to-sql-date [str]
  (c/to-sql-date (dt-parser str)))

(defn convert-date-if-present [ m kw ]
  (if (identity (kw m))
    (update-in m [kw] to-sql-date ) m))

(defn convert-dates-if-present [ m ]
    (-> m
        (convert-date-if-present :birthdate)
        (convert-date-if-present :deathdate)
        (convert-date-if-present :add_date)
        (convert-date-if-present :orig_air_date)
        (convert-date-if-present :release_date)
        (convert-date-if-present :updated_date)))




(defn numeric? [s]
  (if-let [s (seq s)]
    (let [s (if (= (first s) \-) (next s) s)
          s (drop-while #(Character/isDigit %) s)
          s (if (= (first s) \.) (next s) s)
          s (drop-while #(Character/isDigit %) s)]
      (empty? s))))

(defn cond-quote [ val ]
  (if (numeric? val) val (str "'" val "'")))


(defn gen-where-from-params [ params & op ]
  (let [ operator (if (empty? op) "=" (first op)) ]
    (clojure.string/join " and " (map #(str (name %) operator "?") (keys params)))))

(defn gen-where-for-each-column [ table op ]
  (let [ cols (keys (into {} (filter #(= (second %) :varchar) (get-in (erindb-meta-data) [ :columns table])))) ]
    (clojure.string/join " or " (map #(str (name %) op "?") cols))))


(defn gen-sql-to-search-all-char-columns [table term]
  (jdbc/query pgdb
              [(str "select * from " (add-schema table) " where " (gen-where-for-each-column table " like "))]))



