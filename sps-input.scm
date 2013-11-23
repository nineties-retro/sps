;
;
;

(define (sps:input:refill ops) 
  (sps:word-vector:ref ops 0))

(define (sps:input:close ops)
  (sps:word-vector:ref ops 1))

(define (sps:input:buffer ops)
  (sps:word-vector:ref ops 2))

(define sps:input:size (* 3 sps:bytes-per-word))
