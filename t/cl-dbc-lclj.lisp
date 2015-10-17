(in-package :cl-user)
(defpackage cl-dbc-lclj-test
  (:use :cl
        :cl-dbc-lclj
        :prove))
(in-package :cl-dbc-lclj-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-dbc-lclj)' in your Lisp.

(plan nil)

(is-expand (cl-dbc-lclj::make-asserts ((not (zerop 1)) (numberp 1)))
           (PROGN
             (ASSERT (NOT (ZEROP 1)))
             (ASSERT (NUMBERP 1))))


(finalize)
