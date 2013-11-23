;
;
;
(define sps:input:file::buffer-size 16384)

                                  ; SPSINFIL
(define sps:input:file::tag-value #x56512F17)

(define (sps:input:file::tag i)
  (sps:word-vector:ref i 0))
(define (sps:input:file::tag! i v)
  (sps:word-vector:set! i 0 v))

(define (sps:input:file? i) 
  (= (sps:input:file::tag i) sps:input:file::tag-value))

(define (sps:input:file::buffer i)
  (sps:assert (sps:input:file? i))
  (sps:word-vector:ref i 1))
(define (sps:input:file::buffer! i v)
  (sps:assert (sps:input:file? i))
  (sps:word-vector:set! i 1 v))

(define (sps:input:file::port i)
  (sps:assert (sps:input:file? i))
  (sps:word-vector:ref i 2))
(define (sps:input:file::port! i v)
  (sps:assert (sps:input:file? i))
  (sps:word-vector:set! i 2 v))

(define (sps:input:file::file-name i)
  (sps:assert (sps:input:file? i))
  (sps:word-vector:ref  i 3))
(define (sps:input:file::file-name! i v)
  (sps:assert (sps:input:file? i))
  (sps:word-vector:set! i 3 v))

(define sps:input:file:size (* 4 sps:bytes-per-word))

(define (sps:input:file::dump i)
  (sps:assert (sps:input:file? i))
  (let ((op (sps:io:stdout)))
    (sps:and
      (sps:io:print:string op "INPUT-FILE - ")
      (sps:io:print:hex-int op i)
      (sps:io:newline op)
      (sps:io:print:string op "  buffer    = ")
      (sps:io:print:hex-int op (sps:input:file::buffer i))
      (sps:io:newline op)
      (sps:io:print:string op "  port      = ")
      (sps:io:print:hex-int op (sps:input:file::port i))
      (sps:io:newline op)
      (sps:io:print:string op "  file-name = ")
      (sps:io:print:string op (sps:input:file::file-name i))
      (sps:io:newline op))))


(define (sps:input:file::refill i)
  (let* ((buffer (sps:input:file::buffer i))
         (port (sps:input:file::port i)))
    (sps:io:read port buffer sps:input:file::buffer-size)))

(define (sps:input:file::close i)
  (let ((port (sps:input:file::port i)))
    (sps:io:close port)))

(define (sps:input:file:open i file-name pool pool-ops)
  (let* ((port (sps:io:open-input file-name))
         (alloc (sps:mem:pool:alloc pool-ops))
         (buffer (alloc pool sps:input:file::buffer-size 1)))
    (sps:if buffer
        (begin
          (sps:input:file::tag! i sps:input:file::tag-value)
          (sps:input:file::buffer! i buffer)
          (sps:input:file::port! i port)
          (sps:input:file::file-name! i file-name)
          #t)
        (sps:io:close port))))

(define-static-vector sps:input:file:ops
  (sps:input:file::refill
   sps:input:file::close
   sps:input:file::buffer))
