(defproject erin "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :min-lein-version "2.0.0"
  :dependencies [[org.clojure/clojure "1.6.0"]
                 [compojure "1.3.1"]
                 [ring/ring-defaults "0.1.2"]
                 [ring-server "0.4.0"]
                 [org.clojure/java.jdbc "0.3.2"]
                 [org.webbitserver/webbit "0.4.14"]
                 [clj-time "0.9.0"]
                 [clj-yaml "0.4.0"]
                 [org.clojure/tools.logging "0.3.1"]
                 [org.slf4j/slf4j-log4j12 "1.7.1"]
                 [log4j/log4j "1.2.17" :exclusions [javax.mail/mail
                                                    javax.jms/jms
                                                    com.sun.jmdk/jmxtools
                                                    com.sun.jmx/jmxri]]
                 [ring-basic-authentication "1.0.5"]
                 [org.postgresql/postgresql "9.2-1002-jdbc4"]
            		[ring/ring-json "0.2.0"]]
  :plugins [[lein-ring "0.8.13"]]
  :ring {:handler erin.handler/app :init erin.handler/init }
  :profiles
  {:dev {:dependencies [[javax.servlet/servlet-api "2.5"]
                        [ring-mock "0.1.5"]]}}
  :aot  [erin.handler]
  :main erin.handler
  )
