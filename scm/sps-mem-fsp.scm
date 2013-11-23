(define (sps:mem:fsp:open pools size alignment) 'fixed-size-pool)

(define (sps:mem:fsp:alloc fsp size alignment)
  (sps:assert (eq? fsp 'fixed-size-pool))
  (case alignment
    ((1) (make-string size))
    ((4) (make-vector (quotient size sps:bytes-per-word)))
    (else "sps:mem:fsp:alloc - illegal alignment" alignment)))

(define (sps:mem:fsp:free fsp addr)
  (sps:assert (eq? fsp 'fixed-size-pool)))

(define (sps:mem:fsp:close sp)
  (sps:assert (eq? fsp 'fixed-size-pool)))

(define sps:mem:fsp:ops
  (vector sps:mem:fsp:alloc sps:mem:fsp:free sps:mem:fsp:close))
