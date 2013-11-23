(define (sps:mem:pools:open) 'pools)

(define (sps:mem:pool:alloc pool-ops)
  (sps:word-vector:ref pool-ops 0))
(define (sps:mem:pool:free pool-ops)
  (sps:word-vector:ref pool-ops 1))
(define (sps:mem:pool:close pool-ops)
  (sps:word-vector:ref pool-ops 2))

(define sps:mem:pool:size (* 3 sps:bytes-per-word))
