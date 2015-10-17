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
  (is-expand (cl-dbc-lclj::with-dbc
                 (:pre  ((not (zerop n)) (numberp n))
                  :post ((plusp %) (numberp %)))
               (* n n))
             (progn
               (let (($ (match (:pre ((not (zerop n)) (numberp n))
                                :post ((plusp %) (numberp %)))
                          ((property :pre pre-conds) pre-conds)
                          (otherwise t)))
                     ($ (match (:pre ((not (zerop n)) (numberp n))
                                :post ((plusp %) (numberp %)))
                          ((property :post post-conds) post-conds)
                          (otherwise t))))
                 (make-asserts $)
                 (funcall #'(lambda (%)
                              (make-asserts $)
                              %)
                          (progn
                            (* n n)))))))


(finalize)
