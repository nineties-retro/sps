(define *sps-port->integer* '())
(define *sps-integer->port* '())
(define *sps-integer-port-map-size* 0)

(define (sps:port->integer port)
  (let ((pair (assq port *sps-port->integer*)))
    (if pair
        (cdr pair)
        (let ((port-id *sps-integer-port-map-size*))
          (set! *sps-port->integer*
                (cons (cons port port-id) *sps-port->integer*))
          (set! *sps-integer->port*
                (cons (cons port-id port) *sps-integer->port*))
          (set! *sps-integer-port-map-size* (+ port-id 1))
          port-id))))

(define (sps:integer->port port-id)
  (let ((pair (assq port-id *sps-integer->port*)))
    (if pair
        (cdr pair)
        (error 'sps:integer->port 'no-such-port port-id))))


(define sps:io:stdout (sps:port->integer (current-output-port)))

(define (sps:io:write port-id addr length)
  (let ((port (sps:integer->port port-id)))
    (display (substring *sps-store* addr (+ addr length)) port)))

(define sps:io::read-buffer-size 4096)
(define sps:io::read-buffer 
  (make-uniform-vector sps:io::read-buffer-size #\a))

(define (sps:io:read port-id addr length)
  (let* ((port (sps:integer->port port-id))
         (n-read (uniform-vector-read! sps:io::read-buffer port)))
    (let loop ((a addr) (i 0))
      (if (= i n-read)
          n-read
          (begin
            (sps:byte:set! a (char->integer (string-ref sps:io::read-buffer i)))
            (loop (+ a 1) (+ i 1)))))))

(define (sps:io:close port-id)
  (let ((port (sps:integer->port port-id)))
    (close-port port)))

(define (sps:io:open file-name)
  (let* ((len-addr (- file-name sps:bytes-per-word))
         (len (sps:word:ref len-addr))
         (file-name (substring *sps-store* file-name (+ file-name len)))
         (port (open-input-file file-name)))
    (sps:port->integer port)))
