
(cl:in-package :asdf)

(defsystem "beacon_cam-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "cup_camera" :depends-on ("_package_cup_camera"))
    (:file "_package_cup_camera" :depends-on ("_package"))
    (:file "point_transform" :depends-on ("_package_point_transform"))
    (:file "_package_point_transform" :depends-on ("_package"))
  ))