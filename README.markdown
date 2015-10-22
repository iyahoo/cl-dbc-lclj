# CL-DBC-LClJ

Common Lisp with design by contract like Clojure.

## Usage

This provides only macros `defunc` and `with-dbc`.

`defunc` is stands for DEFUN with design by Contract.

```Lisp
(defunc add (x y)
  (:pre ((plusp x))
   :post ((plusp %)))
  (+ x y))

;> (add 3 3)
;=> 6

;> (add -3 3)
;=> The assertion (PLUSP X) failed with X = -3.

;> (add 3 -4)
;=> The assertion (PLUSP %) failed with % = -1.
```

`with-dbc` can check all expression with dbc.

```Lisp
(let ((x 10))
  (with-dbc
    (:pre ((= x 10))
     :post ((= % 21)))
    (+ x x)))
;=> The assertion (= % 21) failed with % = 10.

(with-dbc
  (:post ((= 10 %)))
  10)
;=> 10

(with-dbc
  (:post ((= 10 %)))
  11)
;=> The assertion (= 10 %) failed with % = 11.

```

## Installation
In the folder included in quicklisp path,

`$ git clone https://github.com/iyahoo/cl-dbc-lclj.git`

and on lisp processing,

```Lisp
(ql:quickload :cl-dbc-lclj)
```

## Author

* cl-yaho (s1200191@gmail.com)

## Copyright

Copyright (c) 2015 cl-yaho (s1200191@gmail.com)

## License

Licensed under the LLGPL License.
