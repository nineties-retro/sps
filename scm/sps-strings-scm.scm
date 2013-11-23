(define (sps:byte-vector->string byte-vector start end) 
  (if (and (= start 0) (= end (string-length byte-vector)))
      byte-vector
      (substring byte-vector start end)))

(define sps:string:length string-length)
(define (sps:string:ref string index)
  (char->integer (string-ref string index)))

(define (sps:string:literal string) string)
(define (sps:string:start string)  0)
(define sps:string:end string-length)

(define (sps:static-string s) s)
