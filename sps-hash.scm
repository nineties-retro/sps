;
; PJW hash from Aho, Sethi and Ullman.  Not the fastest hash around by
; any means but sufficient for the job until profiling shows that
; this is a bottleck.

; XXX case sensitive.

(define (sps:hash:string h0 string start end)
  (let loop ((h h0) (g 0) (i start))
    (if (< i end)
        (let* ((c (sps:byte-vector:ref string i))
               (h (sps:word:lsl h 4))
               (h (+ h c))
               (g (sps:word:and h #xf0000000)))
          (if (= g 0)
              (loop h g (+ i 1))
              (let* ((h (sps:word:xor h (sps:word:lsr g 24)))
                     (h (sps:word:xor h g)))
                (loop h g (+ i 1)))))
        h)))

(define (sps:hash:string-literal string-literal start end)
  (let loop ((h 0) (g 0) (i start))
    (if (< i end)
        (let* ((c (sps:string:ref string-literal i))
               (h (sps:word:lsl h 4))
               (h (+ h c))
               (g (sps:word:and h #xf0000000)))
          (if (= g 0)
              (loop h g (+ i 1))
              (let* ((h (sps:word:xor h (sps:word:lsr g 24)))
                     (h (sps:word:xor h g)))
                (loop h g (+ i 1)))))
        h)))
