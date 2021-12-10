
(cl:in-package :asdf)

(defsystem "cam-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Stop" :depends-on ("_package_Stop"))
    (:file "_package_Stop" :depends-on ("_package"))
    (:file "UIntArray" :depends-on ("_package_UIntArray"))
    (:file "_package_UIntArray" :depends-on ("_package"))
  ))