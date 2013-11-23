;
; Fixed size memory pool.
;

                                       ; SPFSPBUF
(define sps:mem:fsp::buffer::tag-value #x56F56BCF)

(define (sps:mem:fsp::buffer::tag b)
  (sps:word-vector:ref b 0))
(define (sps:mem:fsp::buffer::tag! b v)
  (sps:word-vector:set! b 0 v))

(define (sps:mem:fsp::buffer? b) 
  (= (sps:mem:fsp::buffer::tag b) sps:mem:fsp::buffer::tag-value))

(define (sps:mem:fsp::buffer::next-buffer b)
  (sps:assert (sps:mem:fsp::buffer? b))
  (sps:word-vector:ref b 1))
(define (sps:mem:fsp::buffer::next-buffer! b v)
  (sps:assert (sps:mem:fsp::buffer? b))
  (sps:word-vector:set! b 1 v))

(define (sps:mem:fsp::buffer::buffer b)
  (sps:assert (sps:mem:fsp::buffer? b))
  (sps:word-vector:ref b 2))
(define (sps:mem:fsp::buffer::buffer! b v)
  (sps:assert (sps:mem:fsp::buffer? b))
  (sps:word-vector:set! b 2 v))

(define (sps:mem:fsp::buffer::buffer-size b)
  (sps:assert (sps:mem:fsp::buffer? b))
  (sps:word-vector:ref b 3))
(define (sps:mem:fsp::buffer::buffer-size! b v)
  (sps:assert (sps:mem:fsp::buffer? b))
  (sps:word-vector:set! b 3 v))

(define sps:mem:fsp::buffer:size (* 4 sps:bytes-per-word))


(define (sps:mem:fsp::buffer::dump b)
  (sps:assert (sps:mem:fsp::buffer? b))
  (let ((op (sps:io:stdout))
        (nb (sps:mem:fsp::buffer::next-buffer b)))
    (sps:io:print:string op "FSP BUFFER - ")
    (sps:io:print:hex-int op b) 
    (sps:io:newline op)
    (sps:io:print:string op "  next    = ") 
    (sps:io:print:hex-int op nb)
    (sps:io:newline op)
    (sps:io:print:string op "  buffer  = ") 
    (sps:io:print:hex-int op (sps:mem:fsp::buffer::buffer b)) 
    (sps:io:newline op)
    (sps:io:print:string op "  buffer# = ")
    (sps:io:print:int op (sps:mem:fsp::buffer::buffer-size b))
    (sps:io:newline op)
    (and nb (sps:mem:fsp::buffer::dump nb))))



                               ; SPMEMFSP
(define sps:mem:fsp::tag-value #x563E3F56)

(define (sps:mem:fsp::tag fsp)
  (sps:word-vector:ref fsp 0))
(define (sps:mem:fsp::tag! fsp v)
  (sps:word-vector:set! fsp 0 v))

(define (sps:mem:fsp? fsp) 
  (= (sps:mem:fsp::tag fsp) sps:mem:fsp::tag-value))

(define (sps:mem:fsp::pools fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:ref fsp 1))
(define (sps:mem:fsp::pools! fsp v)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:set! fsp 1 v))

(define (sps:mem:fsp::buffer fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:ref fsp 2))
(define (sps:mem:fsp::buffer! fsp v)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:set! fsp 2 v))

(define (sps:mem:fsp::buffer-size fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:ref fsp 3))
(define (sps:mem:fsp::buffer-size! fsp v)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:set! fsp 3 v))

(define (sps:mem:fsp::next-buffer fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:ref fsp 4))
(define (sps:mem:fsp::next-buffer! fsp v)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:set! fsp 4 v))

(define (sps:mem:fsp::ap fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:ref fsp 5))
(define (sps:mem:fsp::ap! fsp v) 
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:set! fsp 5 v))

(define (sps:mem:fsp::fixed-size fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:ref fsp 6))
(define (sps:mem:fsp::fixed-size! fsp v) 
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:set! fsp 6 v))

(define (sps:mem:fsp::alignment fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:ref fsp 7))
(define (sps:mem:fsp::alignment! fsp v) 
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word-vector:set! fsp 7 v))

(define sps:mem:fsp:size (* 8 sps:bytes-per-word))

(define (sps:mem:fsp::dump fsp)
  (sps:assert (sps:mem:fsp? fsp))
  (let ((op (sps:io:stdout))
        (nb (sps:mem:fsp::next-buffer fsp)))
    (sps:io:print:string op "FSP - ")
    (sps:io:print:hex-int op fsp)
    (sps:io:newline op)
    (sps:io:print:string op "  pools   = ")
    (sps:io:print:hex-int op (sps:mem:fsp::pools fsp))
    (sps:io:newline op)
    (sps:io:print:string op "  buffer  = ")
    (sps:io:print:hex-int op (sps:mem:fsp::buffer fsp))
    (sps:io:newline op)
    (sps:io:print:string op "  buffer# = ")
    (sps:io:print:int op (sps:mem:fsp::buffer-size fsp))
    (sps:io:newline op)
    (sps:io:print:string op "  next    = ")
    (sps:io:print:hex-int op nb)
    (sps:io:newline op)
    (sps:io:print:string op "  ap      = ")
    (sps:io:print:hex-int op (sps:mem:fsp::ap fsp))
    (sps:io:newline op)
    (sps:io:print:string op "  size    = ")
    (sps:io:print:int op (sps:mem:fsp::fixed-size fsp))
    (sps:io:newline op)
    (sps:io:print:string op "  align   = ")
    (sps:io:print:int op (sps:mem:fsp::alignment fsp))
    (sps:io:newline op)
    (and nb (sps:mem:fsp::buffer::dump nb))))


;
; Create a new buffer header and link it into fsp.
;
(define (sps:mem:fsp::buffer::open fsp)
  (let* ((pools (sps:mem:fsp::pools fsp))
         (ap (sps:mem:pools::alloc-point pools))
         (limit (sps:mem:pools::limit pools)))
    (let ((end-addr (+ ap sps:mem:fsp::buffer:size)))
      (and 
       (< end-addr limit)
       (let ((nb (sps:mem:fsp::next-buffer fsp))
             (bs (sps:mem:fsp::buffer-size fsp)))
         (sps:mem:pools::alloc-point! pools end-addr)
         (sps:mem:fsp::buffer::tag! ap sps:mem:fsp::buffer::tag-value)
         (sps:mem:fsp::buffer::buffer! ap (sps:mem:fsp::buffer fsp))
         (sps:mem:fsp::buffer::next-buffer! ap nb)
         (sps:mem:fsp::buffer::buffer-size! ap bs)
         (sps:mem:fsp::next-buffer! fsp ap)
         (sps:mem:fsp::buffer! fsp 0)
         (sps:mem:fsp::ap! fsp 0)
         #t)))))
       


;
; Create a fixed size pool for blocks of the given <code>size</code>
; and which will be aligned on <code>alignment</code> byte boundaries.
; Returns the pool or 0 if the pool could not be created.
;
(define (sps:mem:fsp:open pools size alignment)
  (let ((ap (sps:mem:pools::alloc-point pools))
        (limit (sps:mem:pools::limit pools)))
    (let ((end-addr (+ ap sps:mem:fsp:size)))
      (if (< end-addr limit)
          (begin
            (sps:mem:pools::alloc-point! pools end-addr)
            (sps:mem:fsp::tag! ap sps:mem:fsp::tag-value)
            (sps:mem:fsp::pools! ap pools)
            (sps:mem:fsp::buffer! ap 0)
            (sps:mem:fsp::next-buffer! ap 0)
            (sps:mem:fsp::ap! ap 0)
            (sps:mem:fsp::fixed-size! ap size)
            (sps:mem:fsp::alignment! ap alignment)
            ap)
          0))))

(define (sps:mem:fsp::init base-addr fixed-size alignment buffer-size)
  (let* ((alignment-inc (- alignment 1))
         (alignment-mask (sps:word:not alignment-inc))
         (size (sps:word:and (+ fixed-size alignment-inc) alignment-mask))
         (n-chunks (quotient buffer-size size))
         (last-chunk-addr (+ base-addr (* size (- n-chunks 1)))))
    (let loop ((addr base-addr))
      (if (< addr last-chunk-addr) 
          (let* ((na (+ addr size)))
            (sps:word:set! addr na)
            (loop na))
          (sps:word:set! last-chunk-addr 0)))))

(define (sps:mem:fsp::page-align addr)
  (sps:word:and (+ addr (- sps:page-size 1))
                (sps:word:not (- sps:page-size 1))))

;
; Allocate a fixed size block of memory.  Returns 
;
(define (sps:mem:fsp:alloc fsp size alignment)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:assert (= size (sps:mem:fsp::fixed-size fsp)))
  (sps:assert (= alignment (sps:mem:fsp::alignment fsp)))
  (let ((ap (sps:mem:fsp::ap fsp)))
    (if ap
        (begin (sps:mem:fsp::ap! fsp (sps:word:ref ap)) ap)
        (if (not (sps:mem:fsp::buffer fsp))
            (let* ((n-bytes (sps:mem:fsp::page-align size))
                   (n-pages (quotient n-bytes sps:page-size))
                   (buffer (sps:mem:range-alloc n-pages)))
              (and 
                buffer
                (begin
                  (sps:mem:fsp::buffer! fsp buffer)
                  (sps:mem:fsp::buffer-size! fsp n-bytes)
                  (sps:mem:fsp::ap! fsp (+ buffer size))
                  (sps:mem:fsp::fixed-size! fsp size)
                  (sps:mem:fsp::init buffer size alignment n-bytes)
                  buffer)))
            (and 
              (sps:mem:fsp::buffer::open fsp)
              (sps:mem:fsp:alloc fsp size alignment))))))

;
; Does not attempt to free up a page if it is all free.
;
(define (sps:mem:fsp:free fsp addr)
  (sps:assert (sps:mem:fsp? fsp))
  (sps:word:set! addr (sps:mem:fsp::ap fsp))
  (sps:mem:fsp::ap! fsp addr))

;
; Close the fixed size pool and free it up along with all the memory that
; was allocated via this pool.
; Returns and unspecified result.
;
(define (sps:mem:fsp:close fsp)
  #t)

(define-static-vector sps:mem:fsp:ops
  (sps:mem:fsp:alloc
   sps:mem:fsp:free
   sps:mem:fsp:close))
