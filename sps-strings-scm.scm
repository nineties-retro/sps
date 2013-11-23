;
; A simple Scheme version of ../sps-strings.scm.  This was used as a
; test-harness for sps-hash-table.scm so that it could be tested
; independently of ../sps-strings.scm.

(define (sps:strings? strings)
  (and (vector? strings) (eq? 'strings (sps:strings::tag strings))))

(define (sps:strings::tag strings)
  (vector-ref strings 0))
(define (sps:strings::tag! strings v)
  (vector-set! strings 0 v))

(define (sps:strings::buffer strings) 
  (sps:assert (sps:strings? strings))
  (vector-ref strings 1))

(define (sps:strings::buffer! strings v) 
  (sps:assert (sps:strings? strings))
  (vector-set! strings 1 v))

(define (sps:strings::total-length strings) 
  (sps:assert (sps:strings? strings))
  (vector-ref strings 2))

(define (sps:strings::total-length! strings v) 
  (sps:assert (sps:strings? strings))
  (vector-set! strings 2 v))

(define sps:strings:size (* 3 sps:bytes-per-word))

(define (sps:strings:add strings string start end)
  (let ((buffer (sps:strings::buffer strings))
        (total-length (sps:strings::total-length strings)))
    (let ((new-total-length (+ total-length (- end start))))
      (sps:byte-vector:copy! buffer total-length string start end)
      (sps:strings::total-length! strings new-total-length)
      (substring buffer 0 new-total-length))))

(define (sps:strings:commit strings)
  (let ((tl (sps:strings::total-length strings))
        (buffer (sps:strings::buffer strings)))
    (sps:strings::total-length! strings 0)
    (substring buffer 0 tl)))

(define (sps:strings:add+commit strings string start end)
  (sps:strings:add strings string start end)
  (sps:strings:commit strings))
  
(define (sps:strings:release strings) 
  (sps:strings::total-length! strings 0))

(define (sps:strings:open strings pools)
  (sps:strings::tag! strings 'strings)
  (sps:strings::buffer! strings (make-string 128 #\x))
  (sps:strings::total-length! strings 0)
  #t)


(define (sps:strings:close strings)
  (sps:strings:release strings))

(define sps:strings:string:length string-length)
(define sps:strings:string:ref sps:string:ref)
(define (sps:strings:string:start s) 0)
(define (sps:strings:string:literal s) s)
(define sps:strings:string:end string-length)
