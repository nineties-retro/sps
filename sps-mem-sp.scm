;
; As its name might suggest a stack pool allocates objects on a stack
; and with the intent that all the objects can be released by simply
; re-setting the stack pointer rather that individually freeing each
; object.  The C stack is such an object but we are not free to
; allocate on that since that also holds return addresses and the
; stack pool is meant to be independent of that.  Could mmap a region
; and auto-extend it on a page fault but that's complicates the
; bootstrap process so instead we just keep a linked-list of regions,
; where each individual region is treated as a stack and if the region
; is not big enough then another region is allocated and linked to the
; previous region.  This means that restting the allocation point is
; not constant time, instead it takes time proportional to the number
; of regions that are being released as a side-effect of re-setting
; the allocation point.
;

                                      ; SPSSPBUF
(define sps:mem:sp::buffer::tag-value #x56556BCF)

(define (sps:mem:sp::buffer::tag b)
  (sps:word-vector:ref b 0))
(define (sps:mem:sp::buffer::tag! b v)
  (sps:word-vector:set! b 0 v))

(define (sps:mem:sp::buffer? b) 
  (= (sps:mem:sp::buffer::tag b) sps:mem:sp::buffer::tag-value))

(define (sps:mem:sp::buffer::next-buffer b)
  (sps:assert (sps:mem:sp::buffer? b))
  (sps:word-vector:ref b 1))
(define (sps:mem:sp::buffer::next-buffer! b v)
  (sps:assert (sps:mem:sp::buffer? b))
  (sps:word-vector:set! b 1 v))

(define (sps:mem:sp::buffer::buffer b)
  (sps:assert (sps:mem:sp::buffer? b))
  (sps:word-vector:ref b 2))
(define (sps:mem:sp::buffer::buffer! b v)
  (sps:assert (sps:mem:sp::buffer? b))
  (sps:word-vector:set! b 2 v))

(define (sps:mem:sp::buffer::buffer-size b)
  (sps:assert (sps:mem:sp::buffer? b))
  (sps:word-vector:ref  b 3))
(define (sps:mem:sp::buffer::buffer-size! b v)
  (sps:assert (sps:mem:sp::buffer? b))
  (sps:word-vector:set! b 3 v))

(define sps:mem:sp::buffer:size (* 4 sps:bytes-per-word))


(define (sps:mem:sp::buffer::dump b)
  (sps:assert (sps:mem:sp::buffer? b))
  (let ((op (sps:io:stdout))
        (nb (sps:mem:sp::buffer::next-buffer b)))
    (sps:io:print:string op "SP BUFFER - ") 
    (sps:io:print:hex-int op b)
    (sps:io:newline op)
    (sps:io:print:string op "  next    = ") 
    (sps:io:print:hex-int op nb)
    (sps:io:newline op)
    (sps:io:print:string op "  buffer  = ") 
    (sps:io:print:hex-int op (sps:mem:sp::buffer::buffer b)) 
    (sps:io:newline op)
    (sps:io:print:string op "  buffer# = ")
    (sps:io:print:int op (sps:mem:sp::buffer::buffer-size b))
    (sps:io:newline op)
    (sps:and nb (sps:mem:sp::buffer::dump nb))))


                              ; SPSMEMSP
(define sps:mem:sp::tag-value #x5653E356)

(define (sps:mem:sp::tag sp)
  (sps:word-vector:ref sp 0))
(define (sps:mem:sp::tag! sp v)
  (sps:word-vector:set! sp 0 v))

(define (sps:mem:sp? sp) 
  (= (sps:mem:sp::tag sp) sps:mem:sp::tag-value))

(define (sps:mem:sp::pools sp)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:ref sp 1))
(define (sps:mem:sp::pools! sp v)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:set! sp 1 v))

(define (sps:mem:sp::buffer sp)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:ref sp 2))
(define (sps:mem:sp::buffer! sp v)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:set! sp 2 v))

(define (sps:mem:sp::buffer-size sp)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:ref sp 3))
(define (sps:mem:sp::buffer-size! sp v)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:set! sp 3 v))

(define (sps:mem:sp::next-buffer sp)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:ref sp 4))
(define (sps:mem:sp::next-buffer! sp v)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:set! sp 4 v))

(define (sps:mem:sp::ap sp)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:ref sp 5))
(define (sps:mem:sp::ap! sp v) 
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:set! sp 5 v))

(define (sps:mem:sp::limit sp)
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:ref sp 6))
(define (sps:mem:sp::limit! sp v) 
  (sps:assert (sps:mem:sp? sp))
  (sps:word-vector:set! sp 6 v))

(define sps:mem:sp:size (* 7 sps:bytes-per-word))


(define (sps:mem:sp::dump sp)
  (sps:assert (sps:mem:sp? sp))
  (let ((op (sps:io:stdout))
        (nb (sps:mem:sp::buffer::next-buffer sp)))
    (sps:io:print:string op "SP - ")
    (sps:io:print:hex-int op sp)
    (sps:io:newline op)
    (sps:io:print:string op "  pools   = ")
    (sps:io:print:hex-int op (sps:mem:sp::pools sp))
    (sps:io:newline op)
    (sps:io:print:string op "  buffer  = ")
    (sps:io:print:hex-int op (sps:mem:sp::buffer sp))
    (sps:io:newline op)
    (sps:io:print:string op "  buffer# = ")
    (sps:io:print:int op (sps:mem:sp::buffer-size sp))
    (sps:io:newline op)
    (sps:io:print:string op "  next    = ")
    (sps:io:print:hex-int op nb)
    (sps:io:newline op)
    (sps:io:print:string op "  ap      = ")
    (sps:io:print:hex-int op (sps:mem:sp::ap sp))
    (sps:io:newline op)
    (sps:and nb (sps:mem:sp::buffer::dump nb))))



;
; Create a new buffer header and link it into sp.
;
(define (sps:mem:sp::buffer::open sp)
  (let* ((pools (sps:mem:sp::pools sp))
         (ap (sps:mem:pools::alloc-point pools))
         (limit (sps:mem:pools::limit pools)))
    (let ((end-addr (+ ap sps:mem:sp::buffer:size)))
      (sps:and
       (< end-addr limit)
       (let ((nb (sps:mem:sp::next-buffer sp))
             (bs (sps:mem:sp::buffer-size sp)))
         (sps:mem:pools::alloc-point! pools end-addr)
         (sps:mem:sp::buffer::tag! ap sps:mem:sp::buffer::tag-value)
         (sps:mem:sp::buffer::buffer! ap (sps:mem:sp::buffer sp))
         (sps:mem:sp::buffer::next-buffer! ap nb)
         (sps:mem:sp::buffer::buffer-size! ap bs)
         (sps:mem:sp::next-buffer! sp ap)
         (sps:mem:sp::buffer! sp 0)
         (sps:mem:sp::ap! sp 0)
         #t)))))

;
; Create a new stack pool.
; Returns the pool or 0 if the pool could not be created.
;
(define (sps:mem:sp:open pools)
  (let ((ap (sps:mem:pools::alloc-point pools))
        (limit (sps:mem:pools::limit pools)))
    (let ((end-addr (+ ap sps:mem:sp:size)))
      (sps:and
       (< end-addr limit)
       (begin
         (sps:mem:pools::alloc-point! pools end-addr)
         (sps:mem:sp::tag! ap sps:mem:sp::tag-value)
         (sps:mem:sp::pools! ap pools)
         (sps:mem:sp::buffer! ap 0)
         (sps:mem:sp::next-buffer! ap 0)
         (sps:mem:sp::ap! ap 0)
         ap)))))

; XXX: should attatch to an existing sp not create a new one.
(define (sps:mem:sp:obtain pools)
  (sps:mem:sp:open pools))

(define (sps:mem:sp::page-align addr)
  (sps:word:and (+ addr (- sps:page-size 1))
                (sps:word:not (- sps:page-size 1))))

(define (sps:mem:sp:alloc sp size alignment)
  (sps:assert (sps:mem:sp? sp))
  (let ((ap (sps:mem:sp::ap sp)))
    (cond ((not (zero? ap))
           (let* ((inc (- alignment 1))
                  (mask (sps:word:not inc))
                  (aap (sps:word:and (+ ap inc) mask))
                  (limit (sps:mem:sp::limit sp))
                  (nap (+ aap size)))
             (if (< nap limit)
                 (begin (sps:mem:sp::ap! sp nap) aap)
                 (sps:and (sps:mem:sp::buffer::open sp)
                          (sps:mem:sp:alloc sp size alignment)))))
          ((zero? (sps:mem:sp::buffer sp))
           (let* ((n-bytes (sps:mem:sp::page-align size))
                  (n-pages (quotient n-bytes sps:page-size))
                  (buffer (sps:mem:range-alloc n-pages)))
             (sps:and buffer
                 (begin
                   (sps:mem:sp::buffer! sp buffer)
                   (sps:mem:sp::buffer-size! sp n-bytes)
                   (sps:mem:sp::ap! sp (+ buffer size))
                   (sps:mem:sp::limit! sp (+ buffer n-bytes))
                   buffer))))
          (else
           (sps:and (sps:mem:sp::buffer::open sp)
                    (sps:mem:sp:alloc sp size alignment))))))


(define (sps:mem:sp::free-old sp addr buffer)
  (let* ((bs (sps:mem:sp::buffer::buffer buffer))
         (bl (sps:mem:sp::buffer::buffer-size buffer))
         (be (+ bs bl))
         (nb (sps:mem:sp::buffer::next-buffer buffer)))
    (cond ((and (< bs addr) (< addr be))
           (sps:mem:sp::buffer! sp bs)
           (sps:mem:sp::buffer-size! sp bl)
           (sps:mem:sp::ap! sp addr)
           (sps:mem:sp::limit! sp be)
           (sps:mem:sp::next-buffer! sp nb)
           ; FIXME: free up the buffer
           )
          ((not (zero? nb))
           (sps:mem:range-free bs be)
           (sps:mem:sp::free-old sp addr nb))
          (else
           (sps:mem:sp::dump sp)
           (sps:abort)))))

;
; Free all memory allocated by the stack pool down to the given
; address.
;
; XXX: Does not attempt to free up a page if it is all free.
;
(define (sps:mem:sp:free sp addr)
  (let* ((bs (sps:mem:sp::buffer sp))
         (ap (sps:mem:sp::ap sp)))
    (if (and (< bs addr) (< addr ap))
        (sps:mem:sp::ap! sp addr)
        (let ((nb (sps:mem:sp::next-buffer sp)))
          (sps:if nb
              (begin
                (sps:mem:range-free bs (sps:mem:sp::limit sp))
                (sps:mem:sp::free-old sp addr nb))
              (begin
                (sps:mem:sp::dump sp)
                (sps:abort)))))))
              

(define (sps:mem:sp::close-old buffer)
  (and (not (zero? buffer))
       (let* ((bs (sps:mem:sp::buffer::buffer buffer))
              (bl (sps:mem:sp::buffer::buffer-size buffer))
              (be (+ bs bl))
              (nb (sps:mem:sp::buffer::next-buffer buffer)))
         (sps:mem:range-free bs be)
         ; FIXME: free up the buffer.
         (sps:mem:sp::close-old nb))))


;
; Close the stack pool and free it up along with all the memory that
; was allocated via this stack pool.
; Returns and unspecified result.
;
(define (sps:mem:sp:close sp)
  (let* ((bs (sps:mem:sp::buffer sp))
         (bl (sps:mem:sp::limit sp))
         (nb (sps:mem:sp::next-buffer sp)))
    (sps:mem:range-free bs bl)
    (sps:mem:sp::close-old nb)))


(define-static-vector sps:mem:sp:ops
  (sps:mem:sp:alloc
   sps:mem:sp:free
   sps:mem:sp:close))
