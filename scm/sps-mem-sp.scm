(define (sps:mem:sp:open pools) 'stack-pool)

(define (sps:mem:sp:obtain pools) 'stack-pool)

(define (sps:mem:sp:alloc sp size alignment)
  (sps:assert (eq? sp 'stack-pool))
  (case alignment
    ((1) (make-string size #\x))
    ((4) (make-vector (quotient size sps:bytes-per-word)))
    (else "sps:mem:sp:alloc - illegal alignment" alignment)))

(define (sps:mem:sp:free sp addr)
  (sps:assert (eq? sp 'stack-pool)))

(define (sps:mem:sp:close sp)
  (sps:assert (eq? sp 'stack-pool)))

(define sps:mem:sp:ops
  (vector sps:mem:sp:alloc sps:mem:sp:free sps:mem:sp:close))
