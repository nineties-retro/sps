(defmacro define-static-vector (id . exprs)
  `(define ,id (vector ,@(car exprs))))

(defmacro define-forward args #t)

(define sps:bytes-per-word 4)
(define (sps:make-static-vector l)
  (make-vector (quotient l sps:bytes-per-word)))
(define sps:static-vector vector)
(define (sps:procedure->integer proc) proc)
(define (sps:integer->procedure proc-id) proc-id)
