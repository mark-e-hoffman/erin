(ns erin.database-test
  (:require [clojure.test :refer :all]
            [erin.database :refer :all]))

(deftest test-app
  (testing "add schema for artists"
    (let [response (add-schema :artists)]
      (is (= response) "erin.artists"))))

