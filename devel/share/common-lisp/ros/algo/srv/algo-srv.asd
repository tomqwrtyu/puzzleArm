
(cl:in-package :asdf)

(defsystem "algo-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "num_state" :depends-on ("_package_num_state"))
    (:file "_package_num_state" :depends-on ("_package"))
  ))