(define sps:char-map:illegal      #b00000000000)
(define sps:char-map:id           #b00000000001)
(define sps:char-map:digit        #b00000000010)
(define sps:char-map:str          #b00000000100)
(define sps:char-map:ws           #b00000001000)
(define sps:char-map:list-open    #b00000010000)
(define sps:char-map:list-close   #b00000100000)
(define sps:char-map:sign         #b00001000000)
(define sps:char-map:newline      #b00010000000)
(define sps:char-map:comment      #b00100000000)
(define sps:char-map:hex-digit    #b01000000000)
(define sps:char-map:period       #b10000000000)

(define-static-vector sps:char-map:map
  (sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:ws                            ; \t
   (+ sps:char-map:ws sps:char-map:newline)   ; \n
   sps:char-map:ws                            ; \v
   sps:char-map:ws                            ; \f
   sps:char-map:ws                            ; \r
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal             ;
   sps:char-map:ws                  ; #\space
   sps:char-map:id                  ; #\!
   sps:char-map:str                 ; #\"
   sps:char-map:illegal             ; #\#
   sps:char-map:id                  ; #\$
   sps:char-map:id                  ; #\%
   sps:char-map:id                  ; #\&
   sps:char-map:illegal             ; #\'
   sps:char-map:list-open           ; #\(
   sps:char-map:list-close          ; #\)
   sps:char-map:id                  ; #\*
   sps:char-map:sign                ; #\+
   sps:char-map:illegal             ; #\,
   sps:char-map:sign                ; #\-
   sps:char-map:period              ; #\.
   sps:char-map:id                  ; #\/
   sps:char-map:digit               ; #\0
   sps:char-map:digit               ; #\1
   sps:char-map:digit               ; #\2
   sps:char-map:digit               ; #\3
   sps:char-map:digit               ; #\4
   sps:char-map:digit               ; #\5
   sps:char-map:digit               ; #\6
   sps:char-map:digit               ; #\7
   sps:char-map:digit               ; #\8
   sps:char-map:digit               ; #\9
   sps:char-map:id                  ; #\:
   sps:char-map:comment             ; #\;
   sps:char-map:id                  ; #\<
   sps:char-map:id                  ; #\=
   sps:char-map:id                  ; #\>
   sps:char-map:id                  ; #\?
   sps:char-map:illegal             ; #\@
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\A
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\B
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\C
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\D
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\E
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\F
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id                  ; #\Z
   sps:char-map:illegal             ; #\[
   sps:char-map:illegal             ; #\\
   sps:char-map:illegal             ; #\]
   sps:char-map:id                  ; #\^
   sps:char-map:id                  ; #\_
   sps:char-map:illegal             ; #\`
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\a
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\b
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\c
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\d
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\e
   (+ sps:char-map:id sps:char-map:hex-digit) ; #\f
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id
   sps:char-map:id                  ; #\z
   sps:char-map:id                  ; #\{
   sps:char-map:id                  ; #\|
   sps:char-map:id                  ; #\}
   sps:char-map:id                  ; #\~
   sps:char-map:illegal             ; DEL
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal
   sps:char-map:illegal))
