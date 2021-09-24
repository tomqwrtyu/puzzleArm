
(cl:in-package :asdf)

(defsystem "cam-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "goal" :depends-on ("_package_goal"))
    (:file "_package_goal" :depends-on ("_package"))
  ))