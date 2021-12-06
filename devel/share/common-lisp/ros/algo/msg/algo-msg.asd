
(cl:in-package :asdf)

(defsystem "algo-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "stringArray" :depends-on ("_package_stringArray"))
    (:file "_package_stringArray" :depends-on ("_package"))
    (:file "timeStamp" :depends-on ("_package_timeStamp"))
    (:file "_package_timeStamp" :depends-on ("_package"))
  ))