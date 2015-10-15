#|
  This file is a part of cl-dbc-lclj project.
  Copyright (c) 2015 cl-yaho (s1200191@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-dbc-lclj-test-asd
  (:use :cl :asdf))
(in-package :cl-dbc-lclj-test-asd)

(defsystem cl-dbc-lclj-test
  :author "cl-yaho"
  :license "LLGPL"
  :depends-on (:cl-dbc-lclj
               :prove)
  :components ((:module "t"
                :components
                ((:test-file "cl-dbc-lclj"))))
  :description "Test system for cl-dbc-lclj"

  :defsystem-depends-on (:prove-asdf)
  :perform (test-op :after (op c)
                    (funcall (intern #.(string :run-test-system) :prove-asdf) c)
                    (asdf:clear-system c)))
