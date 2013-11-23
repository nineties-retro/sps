;
; byte-vector operations that are run under Scheme and SPS.
;

(define (sps:byte-vector:copy! to-vec to-start from-vec from-start from-end)
  (let loop ((i from-start) (j to-start))
    (or (= i from-end)
        (begin
          (sps:byte-vector:set! to-vec j (sps:byte-vector:ref from-vec i))
          (loop (+ i 1) (+ j 1))))))
