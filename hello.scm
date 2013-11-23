;
; Good old "Hello World!" program.
;

(define sps:bytes-per-word 4)
(define-external (+ x y) "sps_word_add")
(define-external (- x y) "sps_word_sub")
(define-external (sps:word:ref addr) "sps_word_ref")
(define-external (sps:io:write port buffer n-bytes) "sps_io_write")
(define-external (sps:io:stdout) "sps_io_stdout")
(define-external (sps:io:newline port) "sps_io_newline")

(define (sps:string:length string)
  (let* ((len-addr (- string sps:bytes-per-word))
         (len (sps:word:ref len-addr)))
    len))

(define (sps:io:write-string port string)
  (sps:io:write port string (sps:string:length string)))
(define (sps:io:print:string port string)
  (sps:io:write-string port string))

(define (main argc argv)
  (let ((op (sps:io:stdout)))
    (sps:io:print:string op "Hello World!")
    (sps:io:newline op)
    1))
