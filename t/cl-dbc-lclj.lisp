(in-package :cl-user)
(defpackage cl-dbc-lclj-test
  (:use :cl
        :cl-dbc-lclj
        :prove))
(in-package :cl-dbc-lclj-test)

;; NOTE: To run this test file, execute `(asdf:test-system :cl-dbc-lclj)' in your Lisp.

(plan nil)

(subtest "make-asserts"
  (is-expand (cl-dbc-lclj::make-asserts ((not (zerop 1)) (numberp 1)))
             (progn
               (assert (not (zerop 1)))
               (assert (numberp 1))))
  (is-expand (cl-dbc-lclj::make-asserts t)
             nil))

(subtest "cond-extracter"
  (is-expand (cl-dbc-lclj::cond-extracter :pre (:pre ((not (= x 0)) (< y 100) (and (oddp x) (evenp y)))
                                   :post ((not (= 0 %)))))
             ((not (= x 0)) (< y 100) (and (oddp x) (evenp y)))))

(finalize)






