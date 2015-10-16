#|
  This file is a part of cl-dbc-lclj project.
  Copyright (c) 2015 cl-yaho (s1200191@gmail.com)
|#

#|
  Author: cl-yaho (s1200191@gmail.com)
|#

(in-package :cl-user)
(defpackage cl-dbc-lclj-asd
  (:use :cl :asdf))
(in-package :cl-dbc-lclj-asd)

(defsystem cl-dbc-lclj
  :version "0.1"
  :author "cl-yaho"
  :license "LLGPL"
  :depends-on (:cl-annot
               :optima
               :alexandria)
  :components ((:module "src"
                :components
                ((:file "cl-dbc-lclj"))))
  :description ""
  :long-description
  #.(with-open-file (stream (merge-pathnames
                             #p"README.markdown"
                             (or *load-pathname* *compile-file-pathname*))
                            :if-does-not-exist nil
                            :direction :input)
      (when stream
        (let ((seq (make-array (file-length stream)
                               :element-type 'character
                               :fill-pointer t)))
          (setf (fill-pointer seq) (read-sequence seq stream))
          seq)))
  :in-order-to ((test-op (test-op cl-dbc-lclj-test))))
