(define sps:page-size 4096)
(define sps:bytes-per-word 4)

(define (sps::align addr)
  (sps:word:and (+ addr (- sps:bytes-per-word 1))
                (sps:word:not (- sps:bytes-per-word 1))))

(define (sps:string->store string addr)
  (let loop ((to-addr addr) (i 0))
    (if (= i (string-length string))
        (begin
          (sps:byte:set! to-addr 0)
          (+ to-addr 1))
        (begin 
          (sps:byte:set! to-addr (char->integer (string-ref str i)))
          (loop (+ to-addr 1) (+ i 1))))))

(define (sps:static-string str)
  (let ((len (string-length str)) (base-addr *sps-store-brk*))
    (sps:word:set! *sps-store-brk* len)
    (let ((string-addr (+ *sps-store-brk* sps:bytes-per-word)))
      (let loop ((to-addr string-addr) (i 0))
        (if (= i len)
            (begin
              (sps:byte:set! to-addr 0)
              (set! *sps-store-brk* (sps::align (+ to-addr 1)))
              string-addr)
            (begin 
              (sps:byte:set! to-addr (char->integer (string-ref str i)))
              (loop (+ to-addr 1) (+ i 1))))))))


(define (sps:make-static-vector length)
  (let ((base-addr *sps-store-brk*))
    (set! *sps-store-brk* (sps::align (+ base-addr length)))
    base-addr))


(define sps:static-vector 
  (lambda values
    (let ((base-addr *sps-store-brk*))
      (let loop ((values values) (addr base-addr))
        (if (null? values)
            (if (< addr sps:page-size)
                (begin
                  (set! *sps-store-brk* addr)
                  base-addr)
                (error 'sps:static-vector 'too-many-statics))
            (let ((value (car values)))
              (sps:word:set! addr value)
              (loop (cdr values) (+ addr sps:bytes-per-word))))))))


(define (sps:display-str str)
  (let* ((len-addr (- str sps:bytes-per-word))
         (len (sps:word:ref len-addr)))
    (sps:io:write sps:io:stdout str len)))

(define (sps:display-substring string start end)
  (let ((len (- end start)))
    (sps:io:write sps:io:stdout (+ string start) len)))

(define (sps:display-int port i)
  (display i))

(define (sps:display-char port c)
  (display c))

(define (sps:display-bool port b)
  (display b))

(define *sps-procedure->integer* '())
(define *sps-integer->procedure* '())
(define *sps-integer-procedure-map-size* 0)

(define (sps:procedure->integer proc)
  (let ((pair (assq proc *sps-procedure->integer*)))
    (if pair
        (cdr pair)
        (let ((proc-id *sps-integer-procedure-map-size*))
          (set! *sps-procedure->integer*
                (cons (cons proc proc-id) *sps-procedure->integer*))
          (set! *sps-integer->procedure*
                (cons (cons proc-id proc) *sps-integer->procedure*))
          (set! *sps-integer-procedure-map-size* (+ proc-id 1))
          proc-id))))

(define (sps:integer->procedure proc-id)
  (let ((pair (assq proc-id *sps-integer->procedure*)))
    (if pair
        (cdr pair)
        (error 'sps:integer->procedure 'no-such-procedure proc-id))))


(define (sps:byte:copy! to-addr from-addr length)
  (let loop ((to-addr to-addr) (from-addr from-addr) (i length))
    (or (zero? i)
        (begin 
          (sps:byte:set! to-addr (sps:byte:ref from-addr))
          (loop (+ to-addr 1) (+ from-addr 1) (- i 1))))))

;(define (sps:char-ci=? a b)
;  (char-ch=? (integer->char a) (integer->char b)))

(define (sps:byte-vector->string byte-vector start end) start)
(define (sps:string:length string)
  (sps:word:ref (- string sps:bytes-per-word)))
(define sps:string-literal:length sps:string:length)
