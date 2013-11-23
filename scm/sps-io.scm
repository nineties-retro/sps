(define sps:io:stdout current-output-port)

(define (sps:io:write port string length)
  (if (= length (string-length string))
      (display string port)
      (display (substring string 0 length) port)))

(define (sps:io:write-substring port string start end)
  (display (substring string start end) port))

(define (sps:io:read port string length)
  (uniform-array-read! string port))

(define (sps:io:close port)
  (close-port port))

(define (sps:io:open-input file-name)
  (open-input-file (sps:string:literal file-name)))

(define (sps:io:open-output file-name)
  (open-output-file (sps:string:literal file-name)))

(define (sps:io:print:string port string)
  (display string port)
  #t)

(define (sps:io:print:int port int)
  (display int port)
  #t)

(define (sps:io:print:hex-int port int)
  (display int port)
  #t)

(define (sps:io:print:char port char)
  (display char port)
  #t)

(define (sps:io:print:bool port bool)
  (display (if bool "1" "0") port)
  #t)

(define (sps:io:newline port)
  (newline port)
  #t)
