(ns erin.database
  (:require [clojure.string])
  (:require [clj-time.core :as t])
  (:require [clj-time.format :as f])
  (:require [clj-time.coerce :as c])
  (:require [clojure.java.jdbc :as jdbc]))

(def multi-parser (f/formatter (t/default-time-zone) "YYYY-MM-dd" "YYYY-MM-dd HH:mm:ss" "YYYY-MM-dd'T'HH:mm:ssZ"))


(def ^{:dynamic true} *pgdb* (ref nil))
(def ^{:dynamic true} *erindb-meta-data* (ref nil))



(defn pgdb [] (deref *pgdb*))

(defn erindb-meta-data [] (deref *erindb-meta-data*))


(defn mk-sql-type-lookup [ p ]
  { (keyword (:column_name p)) (keyword (:udt_name p))})


(defn get-column-type-info
  "create a map of column-name to data-type. Both key and value are keywords
e.g { :id :varchar }"

  [ schema table ]
  { table (into {} (mapcat #(mk-sql-type-lookup % )
                           (jdbc/query (pgdb)
                                       [ "select column_name,udt_name from information_schema.columns where table_schema = ? and table_name = ?"
                                        schema (name table) ])))})


(defn get-columns-type-info
  "create a nested map of tables with column-type info"
  [ ]
  (into {} (mapcat #(get-column-type-info (:schema (erindb-meta-data)) % ) (keys (:tables (erindb-meta-data))))))


(defn init-db [ cfg-fn ]
  (dosync  (ref-set *erindb-meta-data* (cfg-fn [:database :meta-data ])))
  (dosync  (ref-set *pgdb* (cfg-fn [:database :jdbc-driver ])))
  (dosync (ref-set *erindb-meta-data* (assoc (erindb-meta-data) :data-types (get-columns-type-info))))
  (dosync (ref-set *erindb-meta-data* (assoc (erindb-meta-data) :primary-keys (cfg-fn [:database :meta-data :primary-keys]))))
  )


(defn add-schema [ table ]
  (str (:schema (erindb-meta-data)) "." (get-in (erindb-meta-data) [:tables table])))



(defn get-primary-key-column [ table ]
  (println (str "get-primary-key-column:" table "," (:primary-keys (erindb-meta-data))))
  (get-in (erindb-meta-data) [:primary-keys (keyword table) ] "id" ))

(def dt-parser (partial f/parse multi-parser))

(defn to-sql-date [str]
  (c/to-sql-date (dt-parser str)))

(defn parse-int [s]
  (if (instance? Number s) s
    (Integer. (re-find #"[0-9]*" s))))

(defn pass-thru [ f ] f)

(def conversion-map { :varchar pass-thru :timestamp to-sql-date :int4 parse-int :int2 parse-int :date to-sql-date })

(defn prepare-field [ p  dt ]
  (println (str "preparefield:" p "," dt))
  (let [ name (key p)
         value (val p)]
    (println (str "val = " value))
    (if (nil? value) p
        [ name ((dt conversion-map) value ) ])))


(defn prepare-for-statement [ table m]

  (let [sql-table (get-in (erindb-meta-data) [:tables table])
        dt (get-in (erindb-meta-data) [:data-types (keyword sql-table)])]
       (into {} (map #(prepare-field % (get dt (key %))) m))))

(defn add-user-id [ m]
  (assoc m :user_id 1))

(defn gen-where-from-params [ params & op ]
  (if ( empty? params) " 1 = 1 "
    (let [ operator (if (empty? op) "=" (first op)) ]
      (clojure.string/join " and " (map #(str (name %) operator "?") (keys params))))))

(defn gen-where-for-each-column [ table op ]
  (let [ cols (keys (into {} (filter #(= (second %) :varchar) (get-in (erindb-meta-data) [ :columns table])))) ]
    (clojure.string/join " or " (map #(str (name %) op "?") cols))))


(defn gen-sql-to-search-all-char-columns [table term]
  (jdbc/query pgdb
              [(str "select * from " (add-schema table) " where " (gen-where-for-each-column table " like "))]))



