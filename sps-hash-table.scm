; SPS hash table.
;
;
;

                                        ; SPSHTNXX
(define sps:hash-table::node::tag-value #x56587288)

(define (sps:hash-table::node:tag  n)
  (sps:word-vector:ref  n 0))
(define (sps:hash-table::node:tag! n v)
  (sps:word-vector:set! n 0 v))

(define (sps:hash-table::node? t) 
  (= (sps:hash-table::node:tag t) sps:hash-table::node::tag-value))

(define (sps:hash-table::node:next n)
  (sps:assert (sps:hash-table::node? n))
  (sps:word-vector:ref  n 1))
(define (sps:hash-table::node:next! n v)
  (sps:assert (sps:hash-table::node? n))
  (sps:word-vector:set! n 1 v))

(define (sps:hash-table::node:hash n)
  (sps:assert (sps:hash-table::node? n))
  (sps:word-vector:ref  n 2))
(define (sps:hash-table::node:hash! n v)
  (sps:assert (sps:hash-table::node? n))
  (sps:word-vector:set! n 2 v))

(define (sps:hash-table:node:string n)
  (sps:assert (sps:hash-table::node? n))
  (sps:word-vector:ref  n 3))
(define (sps:hash-table:node:string! n v)
  (sps:assert (sps:hash-table::node? n))
  (sps:word-vector:set! n 3 v))

(define sps:hash-table::node:size (* 4 sps:bytes-per-word))

(define (sps:hash-table::node::dump node)
  (let ((op (sps:io:stdout)))
    (sps:and
      (sps:io:print:string op " ")
      (sps:io:print:string op (sps:hash-table:node:string node))
      (sps:io:print:string op " ")
      (sps:io:print:hex-int op (sps:hash-table::node:hash node))
      (let ((next (sps:hash-table::node:next node)))
        (sps:and next (sps:hash-table::node::dump next))))))


(define (sps:hash-table:node:new? n)
  (not (sps:hash-table:node:string n)))


         
                                  ; SPSHTTVX
(define sps:hash-table::tag-value #x565877C8)

(define (sps:hash-table::tag  n)
  (sps:word-vector:ref  n 0))
(define (sps:hash-table::tag! n v)
  (sps:word-vector:set! n 0 v))

(define (sps:hash-table? t) 
  (= (sps:hash-table::tag t) sps:hash-table::tag-value))

(define (sps:hash-table::buckets n)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:ref  n 1))
(define (sps:hash-table::buckets! n v)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:set! n 1 v))

(define (sps:hash-table::n-buckets n)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:ref  n 2))
(define (sps:hash-table::n-buckets! n v)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:set! n 2 v))

(define (sps:hash-table::pools n)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:ref  n 3))
(define (sps:hash-table::pools! n v)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:set! n 3 v))

(define (sps:hash-table::node-pool n)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:ref  n 4))
(define (sps:hash-table::node-pool! n v)
  (sps:assert (sps:hash-table? n))
  (sps:word-vector:set! n 4 v))

(define sps:hash-table:size (* 5 sps:bytes-per-word))


(define (sps:hash-table::dump ht)
  (let ((n-buckets (sps:hash-table::n-buckets ht))
        (buckets (sps:hash-table::buckets ht))
        (op (sps:io:stdout)))
    (sps:io:print:string op "HASH-TABLE")
    (sps:io:newline op)
    (let loop ((i 0))
      (or (= i n-buckets)
          (let ((bucket (sps:word-vector:ref buckets i)))
            (sps:and
              bucket
              (sps:and
                (sps:io:print:string op "  ")
                (sps:io:print:int op i)
                (sps:hash-table::node::dump bucket)
                (sps:io:newline op)))
            (loop (+ i 1)))))))

         

(define (sps:hash-table::make-node table root-node hash-value i)
  (let* ((node-pool (sps:hash-table::node-pool table))
         (size sps:hash-table::node:size)
         (alignment sps:bytes-per-word)
         (node (sps:mem:fsp:alloc node-pool size alignment))
         (buckets (sps:hash-table::buckets table)))
    (sps:and 
      node
      (begin
        (sps:hash-table::node:tag! node sps:hash-table::node::tag-value)
        (sps:hash-table::node:next! node root-node)
        (sps:hash-table::node:hash! node hash-value)
        (sps:hash-table:node:string! node #f)
        (sps:word-vector:set! buckets i node)))
    node))
        
; XXX: case sensitive
(define (sps:hash-table::string-equal a b bs l)
  (let loop ((i 0) (j bs))
    (or (= i l)
        (let ((ac (sps:strings:string:ref a i))
              (bc (sps:byte-vector:ref b j)))
          (and (= ac bc) (loop (+ i 1) (+ j 1)))))))

(define (sps:hash-table:enter table string start end hash-value)
  (let* ((n-buckets (sps:hash-table::n-buckets table))
         (i (remainder hash-value n-buckets))
         (buckets (sps:hash-table::buckets table))
         (sl (- end start))
         (root-node (sps:word-vector:ref buckets i)))
    (let loop ((node root-node))
      (if node
          (let ((ns (sps:hash-table:node:string node))
                (nsh (sps:hash-table::node:hash node)))
            (if (and (= nsh hash-value)
                     (= sl (sps:strings:string:length ns))
                     (sps:hash-table::string-equal ns string start sl))
                node
                (loop (sps:hash-table::node:next node))))
          (sps:hash-table::make-node table root-node hash-value i)))))


(define (sps:hash-table::init-buckets buckets n-buckets)
  (let loop ((i 0))
    (or (= i n-buckets)
        (begin
          (sps:word-vector:set! buckets i #f)
          (loop (+ i 1))))))

(define (sps:hash-table:make-buckets table sp)
  (let* ((alignment sps:bytes-per-word)
         (n-buckets 101)
         (size (* n-buckets sps:bytes-per-word))
         (buckets (sps:mem:sp:alloc sp size alignment)))
    (sps:and 
      buckets
      (begin
        (sps:hash-table::buckets! table buckets)
        (sps:hash-table::n-buckets! table n-buckets)
        (sps:hash-table::init-buckets buckets n-buckets)
        #t))))

(define (sps:hash-table:open table pools)
  (sps:hash-table::tag! table sps:hash-table::tag-value)
  (let ((sp (sps:mem:sp:obtain pools)))
    (sps:and 
     sp
     (let* ((alignment sps:bytes-per-word)
            (size sps:hash-table::node:size)
            (np (sps:mem:fsp:open pools size alignment)))
       (sps:and
        np
        (if (sps:hash-table:make-buckets table sp)
            (begin
              (sps:hash-table::pools! table pools)
              (sps:hash-table::node-pool! table np)
              #t)
            (begin (sps:mem:fsp:close np) #f)))))))


(define (sps:hash-table:close table)
  (sps:mem:fsp:close (sps:hash-table::node-pool table)))
