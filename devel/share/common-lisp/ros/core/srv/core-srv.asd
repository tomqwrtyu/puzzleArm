
(cl:in-package :asdf)

(defsystem "core-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "route_command" :depends-on ("_package_route_command"))
    (:file "_package_route_command" :depends-on ("_package"))
  ))