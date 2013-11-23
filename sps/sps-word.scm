(define (sps:word:lsl v shift) 
  (* v (inexact->exact (/ (log shift) (log 2)))))
(define (sps:word:lsr v shift) 
  (quotient v (inexact->exact (/ (log shift) (log 2)))))
(define sps:word:and logand)
(define sps:word:and? logtest)
(define sps:word:xor logxor)
(define sps:word:not lognot)

(define (sps:word:ref addr)
  (sps:byte-vector:unpack-word *sps-store* addr))

(define (sps:word:set! addr value)
  (sps:byte-vector:pack-word! *sps-store* addr value))

(define (sps:byte:ref addr)
  (char->integer (string-ref *sps-store* addr)))

(define (sps:byte:set! addr value)
  (let ((c (integer->char (if (> 256) (remainder value 256) c))))
    (string-set! *sps-store* addr c)))

(define (sps:word-vector:ref vector index)
  (sps:word:ref (+ vector (* index sps:bytes-per-word))))

(define (sps:word-vector:set! vector index value)
  (sps:word:set! (+ vector (* index sps:bytes-per-word)) value))

(define (sps:byte-vector:ref vector index)
  (sps:byte:ref (+ vector index)))

(define (sps:byte-vector:set! vector index value)
  (sps:byte:set! (+ vector index) value))
