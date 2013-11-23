;
; Variable sized pool
;

(define (sps-mem:vsp::pools vsp)
  (sps:int-ref vsp))
(define (sps-mem:vsp::pools! vsp v)
  (sps:int-set! vsp v))

(define (sps-mem:vsp::buffer vsp)
  (sps:int-ref (+ vsp sps:bytes-per-word)))
(define (sps-mem:vsp::buffer! vsp v)
  (sps:int-set! (+ vsp sps:bytes-per-word) v))

(define (sps-mem:vsp::next vsp)
  (sps:int-ref (+ vsp (* sps:bytes-per-word 2))))
(define (sps-mem:vsp::next! vsp v)
  (sps:int-set! (+ vsp (* sps:bytes-per-word 2)) v))

(define (sps-mem:vsp::head vsp)
  (sps:int-ref (+ vsp (* sps:bytes-per-word 3))))
(define (sps-mem:vsp::head! vsp v) 
  (sps:int-set! (+ vsp (* sps:bytes-per-word 3)) v))

(define (sps-mem:vsp::size vsp)
  (sps:int-ref (+ vsp (* sps:bytes-per-word 4))))
(define (sps-mem:vsp::size! vsp v) 
  (sps:int-set! (+ vsp (* sps:bytes-per-word 4)) v))

(define sps-mem:vsp-size (* 5 sps:bytes-per-word))

(define (sps-mem:vsp::create-pool pools size previous-vsp-pool)
  (let ((ap (sps-mem:pools::alloc-point pools))
        (limit (sps-mem:pools::limit pools)))
    (let ((end-addr (+ ap sps-mem:vsp-size)))
      (if (< end-addr limit)
          (let* ((new-ap (sps:addr->integer end-addr)))
            (sps-mem:pools::alloc-point! pools new-ap)
            (sps-mem:vsp:pools! ap pools)
            (sps-mem:vsp:buffer! ap 0)
            (sps-mem:vsp:next! ap previous-vsp-pool)
            (sps-mem:vsp:head! ap 0)
            (sps-mem:vsp:size! sp size)
            ap)
          (error 'sps-mem:vsp:open 'too-many-pools)))))

(define (sps-mem:vsp:open pools size)
  (sps-mem:vsp::create-pool pools size 0))

(define (sps-mem:vsp::init addr chunk-size block-size)
  (let ((end (+ addr block-size)))
    (let loop ((addr addr))
      (or (= end addr)
          (let ((next-addr (+ addr chunk-size)))
            (sps:int-set! addr next-addr)
            (loop next-addr))))))

(define sps-mem:vsp::header:tag sps-int-ref)
(define (sps-mem:vsp::header:next addr)
  (sps:int-ref (+ addr sps:bytes-per-word)))
(define (sps-mem:vsp::header:next! addr v)
  (sps:int-set! (+ addr sps:bytes-per-word) v))
(define (sps-mem:vsp::header:size addr)
  (sps:int-ref (+ addr (* 2 sps:bytes-per-word))))
(define (sps-mem:vsp::header:size! addr v)
  (sps:int-set! (+ addr (* 2 sps:bytes-per-word)) v))
(define sps-mem:vsp::header-size (* 3 sps:bytes-per-word))

;
; Allocate a fixed size block of memory.  Returns 
;
(define (sps-mem:vsp:alloc vsp n-bytes)
  (let* ((free (sps-mem:vsp::free vsp))
         (prev free)
         (n-units (+ n-bytes sps-mem:vsp::header-size)))
    (if (zero? r)
        ;
        (let loop ((prev prev) (p (sps-mem:vsp::header:next prev)))
          (let ((size (sps-mem:vsp::header:size p)))
            (cond ((>= size n-units)
                   (let ((p (if (= size n-units)
                                (let ((np (sps-mem:vsp::header:next p)))
                                  (sps-mem:vsp::header:next! prev np)
                                  p)
                                (let ((old-size (sps-mem:vsp::header:next p))
                                      (new-size (- old-size n-units))
                                      (np (+ p new-size)))
                                  (sps-mem:vsp::header:size! p old-size)
                                  (sps-mem:vsp::header:size! np n-units)
                                  np))))
                     (sps-mem:vsp::free vsp prev)
                     (+ p sps:bytes-per-word)))
                  ((= p free)           ; wrapped around free list
                   (let ((size (max n-bytes sps:page-size))
                         (new-block (sps-mem:range-alloc size)))
                     (if (zero? new-block)
                         new-block
                         (loop p (sps-mem:vsp:next p)))))
                  (else
                   (error sps:mem:vsp:alloc 'oh-bugger))))))

;
; Does not attempt to free up a page if it is all free.
;
(define (sps-mem:vsp:free vsp addr)
  (let ((bp (- addr sps-mem:vsp::header-size)))
    (let loop ((p (sps-mem:vsp::header:free vsp)))
      (let ((np (sps-mem:vsp::header:next p)))
        (if (or (<= bp p) (>= bp np)
                (>= p
        (if (not (and (> bp p) (< bp np)))
            (if (and (>= p np) (or (> bp p) (< bp np)))
