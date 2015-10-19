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

(subtest "with-dbc"
  (is-expand (with-dbc
                 (:pre ((not (= x 0)) (< y 100) (and (oddp x) (evenp y)))
                  :post ((not (= 0 %))))
               (+ n n))
             (progn
               (cl-dbc-lclj::make-asserts ((not (= x 0)) (< y 100) (and (oddp x) (evenp y))))
               (funcall #'(lambda (cl-dbc-lclj::%)
                            (cl-dbc-lclj::make-asserts ((not (= 0 %))))
                            cl-dbc-lclj::%)
                        (progn
                          (+ n n)))))
  ;; I don't know why this is error. (This is undefined variable: CL-DBC-LCLJ-TEST::%)
  ;; Why evaluation of expression is early than expanding macro?

  ;; (is (let ((n 10))
  ;;       (with-dbc
  ;;           (:pre  ((not (zerop n)) (numberp n))
  ;;            :post ((plusp %) (numberp %)))
  ;;         (* n n)))
  ;;     53)
  )

(finalize)
