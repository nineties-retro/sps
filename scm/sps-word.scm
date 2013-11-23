(define (sps:word:lsl v shift) 
  (* v (inexact->exact (/ (log shift) (log 2)))))
(define (sps:word:lsr v shift) 
  (quotient v (inexact->exact (/ (log shift) (log 2)))))
(define sps:word:and logand)
(define sps:word:and? logtest)
(define sps:word:xor logxor)
(define sps:word:not lognot)

(define sps:word-vector:ref vector-ref)
(define sps:word-vector:set! vector-set!)

(define (sps:byte-vector:ref v i)
  (char->integer (string-ref v i)))

(define (sps:byte-vector:set! v i x)
  (string-set! v i (integer->char x)))
