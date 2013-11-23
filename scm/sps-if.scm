;
; Some macros that attempt to gloss over the fact that whilst Scheme
; distinguishes between 0 and #f, SPS does not.
;

(defmacro sps:if (expr true false) 
  `(let ((sjb:expr ,expr))
     (if (if (integer? sjb:expr) (not (zero? sjb:expr)) sjb:expr)
         ,true
         ,false)))

;(define (sps::scm::convert-expr expr)
;  (let ((n (gentemp)))
;    (list 'let (list (list n expr))
;          (list 'if (list 'integer? n)
;                (list 'if (list 'zero? n)
;                      0
;                      n)
;                n))))

(define (sps::scm::convert-and-expr exprs seed)
  (if (null? exprs)
      seed
      (let ((expr (car exprs)))
        (let ((n (gentemp)))
          (list 'let (list (list n expr))
                (list 'if (list 'and n 
                                (list 'not (list 'and (list 'integer? n)
                                                 (list 'zero? n))))
                      (sps::scm::convert-and-expr (cdr exprs) n)
                      0))))))

(defmacro sps:and exprs
  (sps::scm::convert-and-expr exprs #t))

(define (sps::scm::convert-or-expr exprs seed)
  (if (null? exprs)
      seed
      (let ((expr (car exprs)))
        (let ((n (gentemp)))
          (list 'let (list (list n expr))
                (list 'if (list 'and n 
                                (list 'not (list 'and (list 'integer? n)
                                                 (list 'zero? n))))
                      n
                      (sps::scm::convert-or-expr (cdr exprs) seed)))))))

(defmacro sps:or exprs
  (sps::scm::convert-or-expr exprs #f))

;
; Too lazy to do cond.
;
