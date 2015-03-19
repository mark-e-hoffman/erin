(ns erin.crud
  (:require [erin.database :as db])
  (:require [clojure.java.jdbc :as jdbc]))


(defn segment-control-params [ m ]
  (let [l (get m :_limit 100) o (get m :_offset 0)]
    { :control { :limit l :offset o} :params (dissoc m :_limit :_offset) }))


(defn add-control [ sql control ]
  (str sql " limit " (:limit control) " offset " (:offset control)))

(defn calc-offset [link-type total_found limit offset]
  (case link-type
    :first offset
    :next (+ limit offset)
    :previous (- limit offset)
    :last (- total_found limit)))

(defn gen-limit-and-offset [ link-type found control ]

  (let [ l  (:limit control) o   (:offset control) ]
    (println (str (type l) "," (type found) "," (type o)))
    (case link-type
      :first {:_limit l :_offset 0 }
      :next {:_limit l :_offset (calc-offset :next found l o )}
      :previous  {:_limit l :_offset (calc-offset :previous found l o )}
      :last  {:_limit l :_offset (calc-offset :last found l o)})))

(defn on-last-page? [total_items limit offset ]
  (>= (+ limit offset ) total_items))

(defn add-empty-link [ name]
  { :rel name :href "#" })

(defn add-next-link [ table total_items control params ]
  (if (or (= 0 total_items ) (on-last-page? total_items (:limit control) (:offset control))) (add-empty-link :next)
    { :rel :next
      :href (str "/v1/erin/" (name table) "?" (ring.util.codec/form-encode (merge params (gen-limit-and-offset :next total_items control)))) }))


(defn add-previous-link [ table total_items control params ]
  (if (or (= 0 total_items )
          (= 0 (:offset control))) (add-empty-link :previous)
             { :rel :previous
               :href (str "/v1/erin/" (name table) "?" (ring.util.codec/form-encode (merge params (gen-limit-and-offset :previous total_items control)))) }))


(defn add-first-link [ table total_items control params ]
  (if (or (= 0 total_items ) (= 0 (:offset control))) (add-empty-link :first)
    { :rel :first
     :href (str "/v1/erin/" (name table) "?" (ring.util.codec/form-encode (merge params (gen-limit-and-offset :first total_items control)))) }))


(defn add-last-link [ table total_items control params ]
  (if (or (= 0 total_items ) (on-last-page? total_items (:limit control) (:offset control))) (add-empty-link :last)
       { :rel :last
         :href (str "/v1/erin/" (name table) "?" (ring.util.codec/form-encode (merge params (gen-limit-and-offset :last total_items control))))}))

  (defn add-links [table total_items control params]

    (filter identity
            [
             (add-first-link table total_items control params)
             (add-previous-link table total_items control params)

             (add-next-link table total_items control params)
             (add-last-link table total_items control params)
             ]))


(defn add-search-results-wrapper [ table r total_found control params ]
  (let [ count (:count (first total_found))]
    { :total_items count :items r :links (add-links table count (zipmap (keys control ) (map db/parse-int (vals control ))) params ) }))


(defn search [ table params ]
  (println (str table "," params))
  (let [ m (segment-control-params params) control (:control m) params (:params m) ]

          (do
            (let [where-part (db/gen-where-from-params params )
                  values (vals params)
                  sql (add-control ( str "select * from " (db/add-schema table) " where " where-part ) control)
                  sql-count (str "select count(*) from " (db/add-schema table) " where " where-part)]
              (println sql)
              (let [ count (jdbc/query (db/pgdb) (concat [sql-count] values )) ]
                (add-search-results-wrapper table (jdbc/query (db/pgdb) (concat [sql] values )) count control params ))))))




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
  (first (jdbc/query (db/pgdb) [(str "select * from " (db/add-schema table) " where " (db/get-primary-key-column table) " = ?") id])))

(defn create [ table body ]
  (println (str "Insert of table:" table " with body:" body))
  (jdbc/insert! (db/pgdb) (db/add-schema table ) (db/add-user-id (db/prepare-for-statement table body))))

(defn update [ table id body]
  (println (str "Update of table:" table " with id:" id " with body:" body))
  (jdbc/update! (db/pgdb) (db/add-schema table ) (db/add-user-id  (db/prepare-for-statement table body)) ["id=?" id]))


(defn delete [ table id]
    "Not supported")

