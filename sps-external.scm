;
; Maps a variety of primitive/basic PreScheme values/functions to the
; C values/functions that directly implement them.  Assumes a 32-bit
; target.
;

(define sps:bytes-per-word 4)
(define sps:page-size 4096)
(define-external (+ x y) "sps_word_add")
(define-external (- x y) "sps_word_sub")
(define-external (< x y) "sps_int_lt")
(define-external (> x y) "sps_int_gt")
(define-external (<= x y) "sps_int_le")
(define-external (>= x y) "sps_int_ge")
(define-external (= x y) "sps_word_eq")
(define-external (* x y) "sps_word_mul")
(define-external (not x) "sps_rel_not")
(define-external (quotient x y) "sps_word_quotient")
(define-external (remainder x y) "sps_word_remainder")
(define-external (sps:byte-vector:ref s i) "sps_byte_vector_ref")
(define-external (sps:byte-vector:set! s i v) "sps_byte_vector_set")
(define-external (sps:word-vector:ref v i) "sps_word_vector_ref")
(define-external (sps:word-vector:set! v i x) "sps_word_vector_set")
(define-external (sps:word:lsl w s) "sps_word_lsl")
(define-external (sps:word:lsr w s) "sps_word_lsr")
(define-external (sps:word:and a b) "sps_word_and")
(define-external (sps:word:xor a b) "sps_word_xor")
(define-external (sps:word:not a) "sps_word_not")

(define-external (sps:word:ref addr) "sps_word_ref")
(define-external (sps:word:set! addr value) "sps_word_set")

(define-external (sps:io:open-input file-name) "sps_io_open_input")
(define-external (sps:io:open-output file-name) "sps_io_open_output")
(define-external (sps:io:read port buffer n-bytes) "sps_io_read")
(define-external (sps:io:close port) "sps_io_close")
(define-external (sps:io:write port buffer n-bytes) "sps_io_write")

(define-external (sps:mem:range-alloc n-pages) "sps_mem_range_alloc")
(define-external (sps:mem:range-free start-addr end-addr) "sps_mem_range_free")

(define-external (sps:assert x) "sps_assert")
(define-external (sps:abort) "sps_abort")
(define-external (sps:io:stdout) "sps_io_stdout")
(define-external (char->integer c) "sps_char_to_int")
(define-external (integer->char i) "sps_int_to_char")
(define-external (sps:static-string x) "sps_static_string")

(define (eq? x y) (= x y))
(define (sps:word:and? x y) (sps:word:and x y))
(define (char=? a b) (= a b))
(define (zero? x) (= 0 x))

;
; Unlike C, a PreScheme string inclues the length.  However, To make
; it possible to pass it to C easily then the pointer to the string
; does not point at the length, it points at the data :-
;
;    +---+---+---+---+---+---+---+---+---+---+----+---+---+---+---+---+
;    |   |   |   |   | H | e | l | l | o |   |  W | o | r | l | d | ! |
;    +---+---+---+---+---+---+---+---+---+---+----+---+---+---+---+---+
;    |<--- length -->| ^
;                      |
;                    here
;
(define (sps:string:length string)
  (let* ((len-addr (- string sps:bytes-per-word))
         (len (sps:word:ref len-addr)))
    len))

(define (sps:io:write-string port string)
  (let* ((len (sps:string:length string))
         (n-written (sps:io:write port string len)))
    (= len n-written)))

(define (sps:io:write-substring port string start end)
  (let* ((len (- end start))
         (n-written (sps:io:write port (+ string start) len)))
    (= len n-written)))

(define (sps:io:print:string port string)
  (sps:io:write-string port string))

(define-external (sps:io:print:int port i) "sps_io_print_int")
(define-external (sps:io:print:hex-int port i) "sps_io_print_hex_int")
(define-external (sps:io:print:char port c) "sps_io_print_int")
(define-external (sps:io:print:bool port b) "sps_io_print_int")
(define-external (sps:io:newline port) "sps_io_newline")

(define sps:string:ref sps:byte-vector:ref)
(define (sps:string:start string) 0)
(define (sps:string:literal string) string)
(define sps:string:end sps:string:length)
(define (sps:byte-vector->string buffer start length)
  (+ buffer start))
(define (sps:byte-vector:pack-word! buffer byte-index value)
  (sps:word-vector:set! buffer (quotient byte-index sps:bytes-per-word) value))

(define (sps:byte-vector:unpack-word buffer byte-index)
  (sps:word-vector:ref buffer (quotient byte-index sps:bytes-per-word)))
