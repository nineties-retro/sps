
(define (sps:byte-vector->string byte-vector start end) 
  (vector byte-vector start end))

(define (sps:string:length string)
  (- (vector-ref string 2) (vector-ref string 1)))

(define (sps:string:ref string index)
  (char->integer (string-ref (vector-ref string 0) (+ index (vector-ref string 1)))))

(define (sps:string:literal string) (vector-ref string 0))
(define (sps:string:start string) (vector-ref string 1))
(define (sps:string:end   string) (vector-ref string 2))

(define (sps:static-string s) 
  (sps:byte-vector->string s 0 (string-length s)))
