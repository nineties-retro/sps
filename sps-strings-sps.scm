;
; A string table.  Allows strings to be added a chunk at a time and then
; either commited or released depending on whether the string needs to
; be kept or not.  The string table owns all the strings that are committed
; to it.
;
; The strings are stored in the following format :-
;
; <length><string><alignment-padding><length><string><alignment-padding>...
;
; where <length> is the length of the following string (the size and
; order of <length> is architecture dependent).  The <alignment-padding>
; consists of zero or more bytes to make sure that the next <length>
; starts on the correct alignment boundary.
;
; The string table itself consists of zero or more string buffers.
; For example, the following is an idealised view of the state after
; the strings "abc", "defgh" and "long-string" have been added with
; sps:strings:add+commit in big-endian system with 4 byte words :-
;
;                   +-------+
;     +-------------|       |
;     |             +-------+
;     |             |       |
;     v             +-------+
;  +-----+                                +-----+
;  |     |------------------------------->|     |
;  +-----+                                +-----+
;  |     |                                |     |
;  +-----+                                +-----+
;     |                                      |
;     v                                      |
;  +--------------------------------+        |
;  |0003abcP0005defghPPPUUUUUUUUUUUU|        |
;  +--------------------------------+        |
;                                            v
;                                    +--------------------------------+
;                                    |000Blong-stringPUUUUUUUUUUUUUUUU|
;                                    +--------------------------------+
;
; P represents a padding byte.
; U represents an unused byte.
; Note the length has been written in an abbreviated style.  Since
; all lengths are less than 256, only the bottom 4-bits of each 8-bit
; value are shown and they are shown in HEX rather than as their
; actual value (after trying to write this explanation it convinced me
; that I should probably re-do the diagram to avoid the problem).
;
; NOTES
;
;.byte-vector->string: This peculiar function is here to abstract over
; the different implementations of a string that are used in SPS
; and Scheme.  It is a fairly heavyweight operation in the Scheme
; version but in SPS it should amount to no more than an addition.
;


;
; The default size for a string buffer in bytes.
;
(define sps:strings::default-buffer-length 4096)


                                     ; SPSSTRNG
(define sps:strings::node::tag-value #x5655742C)

(define (sps:strings::node:tag n)
  (sps:word-vector:ref n 0))
(define (sps:strings::node:tag! n v)
  (sps:word-vector:set! n 0 v))

(define (sps:strings::node? n) 
  (= (sps:strings::node:tag n) sps:strings::node::tag-value))

(define (sps:strings::node:next n)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:ref n 1))
(define (sps:strings::node:next! n v)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:set! n 1 v))

(define (sps:strings::node:buffer n)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:ref n 2))
(define (sps:strings::node:buffer! n v)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:set! n 2 v))

(define (sps:strings::node:fill-point n)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:ref n 3))
(define (sps:strings::node:fill-point! n v)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:set! n 3 v))

(define (sps:strings::node:space-left n)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:ref n 4))
(define (sps:strings::node:space-left! n v)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:set! n 4 v))

(define (sps:strings::node:mark-point n)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:ref n 5))
(define (sps:strings::node:mark-point! n v)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:set! n 5 v))


(define (sps:strings::node:mark-left n)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:ref n 6))
(define (sps:strings::node:mark-left! n v)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:set! n 6 v))


(define (sps:strings::node:block-length n)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:ref n 7))
(define (sps:strings::node:block-length! n v)
  (sps:assert (sps:strings::node? n))
  (sps:word-vector:set! n 7 v))

(define sps:strings::node:size (* 8 sps:bytes-per-word))


                                     ; SPSSTRSS
(define sps:strings::tag-value #x56557455)

(define (sps:strings::tag n)
  (sps:word-vector:ref n 0))
(define (sps:strings::tag! n v)
  (sps:word-vector:set! n 0 v))

(define (sps:strings? n) 
  (= (sps:strings::tag n) sps:strings::tag-value))

(define (sps:strings::head n)
  (sps:assert (sps:strings? n))
  (sps:word-vector:ref n 1))
(define (sps:strings::head! n v)
  (sps:assert (sps:strings? n))
  (sps:word-vector:set! n 1 v))

(define (sps:strings::string-pool n)
  (sps:assert (sps:strings? n))
  (sps:word-vector:ref n 2))
(define (sps:strings::string-pool! n v)
  (sps:assert (sps:strings? n))
  (sps:word-vector:set! n 2 v))

(define (sps:strings::node-pool n)
  (sps:assert (sps:strings? n))
  (sps:word-vector:ref n 3))
(define (sps:strings::node-pool! n v)
  (sps:assert (sps:strings? n))
  (sps:word-vector:set! n 3 v))

(define sps:strings:size (* 4 sps:bytes-per-word))

(define (sps:strings::new-node strings)
  (let* ((node-pool (sps:strings::node-pool strings))
         (alignment sps:bytes-per-word)
         (size sps:strings::node:size))
    (sps:mem:fsp:alloc node-pool size alignment)))

(define (sps:strings::handle-overflow strings string start end)
  (let ((nh (sps:strings::new-node strings))
        (head (sps:strings::head strings)))
    (sps:and 
     nh
     (let* ((mp (sps:if head (sps:strings::node:mark-point head) 0))
            (fp (sps:if head (sps:strings::node:fill-point head) 0))
            (len (- end start))
            (mark-length (- fp mp))
            (l (sps:if head
                   (sps:strings::node:block-length head)
                   sps:strings::default-buffer-length))
            (tl (+ mark-length len))
            (tl+size (+ tl sps:bytes-per-word))
            (nl (if (< tl+size l) l (* l (+ 1 (quotient l tl)))))
            (string-pool (sps:strings::string-pool strings))
            (nb (sps:mem:sp:alloc string-pool nl 1))
            (sl (- nl tl+size)))
       (sps:if nb
           (let ((nbs sps:bytes-per-word))
             (sps:and
               mark-length
               (let ((ob (sps:strings::node:buffer head)))
                 (sps:byte-vector:copy! nb nbs ob mp fp)))
             (sps:byte-vector:copy! nb (+ nbs mark-length) string start end)
             (sps:strings::node:tag! nh sps:strings::node::tag-value)
             (sps:strings::node:next! nh head)
             (sps:strings::node:buffer! nh nb)
             (sps:strings::node:fill-point! nh (+ nbs tl))
             (sps:strings::node:space-left! nh sl)
             (sps:strings::node:mark-point! nh nbs)
             (sps:strings::node:mark-left! nh sl)
             (sps:strings::node:block-length! nh nl)
             (sps:strings::head! strings nh)
             (sps:byte-vector:pack-word! nb 0 tl)
             (sps:byte-vector->string nb nbs (+ nbs tl)))
           (let ((node-pool (sps:strings::node-pool strings)))
             (sps:mem:fsp:free node-pool nh)
             #f))))))

;
; Appends the characters beeen [start,end) from string to the string
; buffer.  Returns the start of the string being added to or #f if
; the characters could not be added.  Note that successive calls to 
; add may return different values due to the string being moved inside
; the string buffer.
;
(define (sps:strings:add strings string start end)
  (let ((head (sps:strings::head strings)))
    (sps:if head
        (let ((fp (sps:strings::node:fill-point head))
              (b (sps:strings::node:buffer head))
              (mp (sps:strings::node:mark-point head))
              (sl (sps:strings::node:space-left head))
              (len (- end start)))
          (if (<= len sl)
              (let ((nfp (+ fp len)))
                (sps:byte-vector:copy! b fp string start end)
                (sps:strings::node:fill-point! head nfp)
                (sps:strings::node:space-left! head (- sl len))
                (sps:byte-vector:pack-word! b (- mp sps:bytes-per-word)
                                            (- nfp mp))
                (sps:byte-vector->string b mp nfp))
              (sps:strings::handle-overflow strings string start end)))
        (sps:strings::handle-overflow strings string start end))))


(define (sps:strings::word-align v)
  (let* ((inc (- sps:bytes-per-word 1))
         (mask (sps:word:not inc)))
    (sps:word:and (+ v inc) mask)))


(define (sps:strings:commit strings) 
  (let ((head (sps:strings::head strings)))
    (let ((fp (sps:strings::node:fill-point head))
          (mp (sps:strings::node:mark-point head))
          (b (sps:strings::node:buffer head))
          (sl (sps:strings::node:space-left head)))
      (let* ((nfp (+ (sps:strings::word-align fp) sps:bytes-per-word))
             (nsl (- sl (- nfp fp))))
        (sps:byte-vector:pack-word! b (- mp sps:bytes-per-word) (- fp mp))
        (sps:strings::node:fill-point! head nfp)
        (sps:strings::node:mark-point! head nfp)
        (sps:strings::node:space-left! head nsl)
        (sps:strings::node:mark-left! head nsl)
        (sps:byte-vector->string b mp fp)))))


; This is here because depending on the abstractions used it could
; be more efficient if its is known that a commit will immediately follow the
; add.  Currently no use is made of this fact.  Premature optimiation?

(define (sps:strings:add+commit strings string start end)
  (sps:and
    (sps:strings:add strings string start end)
    (sps:strings:commit strings)))
  
(define (sps:strings:release strings) 
  (let ((head (sps:strings::head strings)))
    (let ((mp (sps:strings::node:mark-point head))
          (ml (sps:strings::node:mark-left head)))
      (sps:strings::node:fill-point! head mp)
      (sps:strings::node:space-left! head ml))))

(define (sps:strings::open-pools strings pools)
  (let ((string-pool (sps:mem:sp:obtain pools)))
    (sps:and
      string-pool
      (let* ((size sps:strings::node:size)
             (alignment sps:bytes-per-word)
             (node-pool (sps:mem:fsp:open pools size alignment)))
        (sps:and
          node-pool
          (begin
            (sps:strings::string-pool! strings string-pool)
            (sps:strings::node-pool! strings node-pool)
            #t))))))

(define (sps:strings:open strings pools)
  (sps:strings::tag! strings sps:strings::tag-value)
  (sps:strings::head! strings 0)
  (sps:strings::open-pools strings pools)
  #t)


(define (sps:strings:close strings)
  (sps:mem:fsp:close (sps:strings::node-pool strings)))


(define sps:strings:string:length  sps:string:length)
(define sps:strings:string:ref     sps:string:ref)
(define sps:strings:string:start   sps:string:start)
(define sps:strings:string:literal sps:string:literal)
(define sps:strings:string:end     sps:string:end)
