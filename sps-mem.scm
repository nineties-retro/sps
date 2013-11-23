(define (sps:mem:pools::root pools)
  (sps:word-vector:ref pools 0))
(define (sps:mem:pools::root! pools v)
  (sps:word-vector:set! pools 0 v))

(define (sps:mem:pools::alloc-point pools)
  (sps:word-vector:ref pools 1))
(define (sps:mem:pools::alloc-point! pools v)
  (sps:word-vector:set! pools 1 v))

(define (sps:mem:pools::next pools)
  (sps:word-vector:ref pools 2))
(define (sps:mem:pools::next! pools v)
  (sps:word-vector:set! pools 2 v))

(define (sps:mem:pools::limit pools)
  (sps:word-vector:ref pools 3))
(define (sps:mem:pools::limit! pools v)
  (sps:word-vector:set! pools 3 v))

(define sps:mem:pools:size (* 4 sps:bytes-per-word))

(define (sps:mem:pools:open)
  (let ((root-page (sps:mem:range-alloc 1)))
    (if (zero? root-page)
        0
        (let ((first-free-addr (+ root-page sps:mem:pools:size)))
          (sps:mem:pools::root! root-page root-page)
          (sps:mem:pools::alloc-point! root-page first-free-addr)
          (sps:mem:pools::next! root-page 0)
          (sps:mem:pools::limit! root-page (+ root-page sps:page-size))
          root-page))))


(define (sps:mem:pool:alloc pool-ops)
  (sps:word-vector:ref pool-ops 0))
(define (sps:mem:pool:free pool-ops)
  (sps:word-vector:ref pool-ops 1))
(define (sps:mem:pool:close pool-ops)
  (sps:word-vector:ref pool-ops 2))

(define sps:mem:pool:size (* 3 sps:bytes-per-word))
