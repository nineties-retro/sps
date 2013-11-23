;
; Pack+unpack a word into a byte-vector.
; Should work on any Scheme which supports 32-bit integers or has bignums.
; Packs in little-endian order since it is being developed on a x86.
;
(define (sps:byte-vector:unpack-word bv start)
  (+    (char->integer (string-ref bv start))
     (* (char->integer (string-ref bv (+ start 1))) 256)
     (* (char->integer (string-ref bv (+ start 2))) 65536)
     (* (char->integer (string-ref bv (+ start 3))) 16777216)))

(define (sps:byte-vector:pack-word! bv start value)
  (sps:assert (integer? value))
  (let ((q (quotient value 16777216)) (r (remainder value 16777216)))
    (string-set! bv (+ start 3) (integer->char q))
    (let ((q (quotient r 65536)) (r (remainder r 65536)))
      (string-set! bv (+ start 2) (integer->char q))
      (let ((q (quotient r 256)) (r (remainder r 256)))
        (string-set! bv (+ start 1) (integer->char q))
        (string-set! bv start (integer->char r))))))


; A big endian pack.
;
;(define (sps:byte-vector:pack-word! bv start value)
;  (sps:assert (integer? value))
;  (let ((q (quotient value 16777216)) (r (remainder value 16777216)))
;    (string-set! bv start (integer->char q))
;    (let ((q (quotient r 65536)) (r (remainder r 65536)))
;      (string-set! bv (+ start 1) (integer->char q))
;      (let ((q (quotient r 256)) (r (remainder r 256)))
;        (string-set! bv (+ start 2) (integer->char q))
;        (string-set! bv (+ start 3) (integer->char r))))))
