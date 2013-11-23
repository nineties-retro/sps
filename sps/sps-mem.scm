(define *sps-store-size* (* 10 sps:page-size))
(define *sps-store* (make-string *sps-store-size*))
(define *sps-store-brk* 0)

(define sps::mem::range  cons)
(define sps::mem::start  car)
(define sps::mem::start! set-car!)
(define sps::mem::end    cdr)
(define sps::mem::end!   set-cdr!)
(define *sps::mem::available-address-ranges*
  (list (sps::mem::range sps:page-size *sps-store-size*)))
(define *sps::mem::used-address-ranges* '())

(define (sps:mem:range-alloc n)
  (let ((required-bytes (* n sps:page-size)))
    (let loop ((address-ranges *sps::mem::available-address-ranges*))
      (if (null? address-ranges)
          0
          (let* ((range (car address-ranges))
                 (start (sps::mem::start range))
                 (end (sps::mem::end range))
                 (size (- end start)))
            (if (< size required-bytes)
                (loop (cdr address-ranges))
                (let* ((x (+ start required-bytes))
                       (new-range (sps::mem::range start x)))
                  (set! *sps::mem::used-address-ranges*
                        (cons new-range *sps::mem::used-address-ranges*))
                  (sps::mem::start! range x)
                  start)))))))

(define (sps:mem:range-free start end)
  (let loop ((next-ranges *sps::mem::used-address-ranges*)
             (found? #f)
             (prev-ranges '()))
    (if (null? next-ranges)
        (if found?
            (set! *sps::mem::used-address-ranges* prev-ranges)
            (error 'sps::mem:range-free start end))
        (let* ((range (car next-ranges))
               (range-start (sps::mem::start range))
               (range-end (sps::mem::end range)))
          (if (= start range-start)
              (begin
                (sps:assert (<= end range-end))
                (set! *sps::mem::available-address-ranges*
                      (cons (sps::mem::range start end)
                            *sps::mem::available-address-ranges*))
                (if (= end range-end)
                    (loop (cdr next-ranges) #t prev-ranges)
                    (loop (cdr next-ranges) 
                          #t
                          (cons (sps::mem::range end range-end)
                                prev-ranges))))
              (loop (cdr next-ranges) found? (cons range prev-ranges)))))))



(define (sps:mem:pools::root pools)
  (sps:word-vector:ref pools 0))
(define (sps:mem:pools::root! pools v)
  (sps:word-vector:set! pools v 0))

(define (sps:mem:pools::alloc-point pools)
  (sps:word-vector:ref pools 1))
(define (sps:mem:pools::alloc-point! pools v)
  (sps:word-vector:set! pools 1 v))

(define (sps:mem:pools::next pools)
  (sps:word-vector:ref pools 2))
(define (sps:mem:pools::next! pools v)
  (sps:word-vector:set! pools 2 v))

(define (sps:mem:pools::limit pools)
  (sps:word-vector:ref pools 3))
(define (sps:mem:pools::limit! pools v)
  (sps:word-vector:set! pools 3 v))

(define sps:mem:pools:size (* 4 sps:bytes-per-word))

(define (sps:mem:pools:open)
  (let ((root-page (sps:mem:range-alloc 1)))
    (if (zero? root-page)
        0
        (let ((first-free-addr (+ root-page sps:mem:pools:size)))
          (sps:mem:pools::root! root-page root-page)
          (sps:mem:pools::alloc-point! root-page first-free-addr)
          (sps:mem:pools::next! root-page 0)
          (sps:mem:pools::limit! root-page (+ root-page sps:page-size))
          root-page))))


(define (sps:mem:pool:alloc pool-ops)
  (sps:integer->procedure (sps:word-vector:ref pool-ops 0)))
(define (sps:mem:pool:free pool-ops)
  (sps:integer->procedure (sps:word-vector:ref pool-ops 1)))
(define (sps:mem:pool:close pool-ops)
  (sps:integer->procedure (sps:word-vector:ref pool-ops 2)))

(define sps:mem:pool:size (* 3 sps:bytes-per-word))
