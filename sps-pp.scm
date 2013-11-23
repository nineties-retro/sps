;
; Uses sps:lexer:lex to lex and print out the contents of a file.
;


(define sps:pp::print display)
(define (sps:pp::print-substring str start end)
  (sps:io:write-substring sps:io:stdout str start end))
(define sps:pp::newline newline)

;(define sps:pp::print (lambda (x) #f))
;(define sps:pp::print-substring (lambda (x y z) #f))
;(define sps:pp::newline (lambda () #f))

(define (sps:pp::print-pos l c)
  (sps:pp::print "[") (sps:pp::print l)
  (sps:pp::print ",")
  (sps:pp::print c) (sps:pp::print "]"))

(define (sps:pp::id lexer state buffer start end line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ID  ")
  (sps:pp::print-substring buffer start end)
  (sps:pp::newline)
  (sps:lexer:lex lexer sps:pp::actions state))

(define (sps:pp::id-chunk lexer state buffer start end line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " IDC ")
  (sps:pp::print-substring buffer start end)
  (sps:pp::newline))

(define (sps:pp::str lexer state buffer start end line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " S   X")
  (sps:pp::print-substring buffer start end)
  (sps:pp::print "X")
  (sps:pp::newline)
  (sps:lexer:lex lexer sps:pp::actions state))

(define (sps:pp::str-chunk lexer state buffer start end line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " SC  X")
  (sps:pp::print-substring buffer start end)
  (sps:pp::print "X")
  (sps:pp::newline))

(define (sps:pp::list-open lexer state line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " (") (sps:pp::newline)
  (sps:lexer:lex lexer sps:pp::actions state))

(define (sps:pp::list-close lexer state line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " )")
  (sps:pp::newline)
  (sps:lexer:lex lexer sps:pp::actions state))

(define (sps:pp::int lexer state i line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " INT ")
  (sps:pp::print i)
  (sps:pp::newline)
  (sps:lexer:lex lexer sps:pp::actions state))

(define (sps:pp::boolean lexer state b line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " BOOL ") 
  (sps:pp::print b)
  (sps:pp::newline)
  (sps:lexer:lex lexer sps:pp::actions state))

(define (sps:pp::char lexer state c line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " CHAR ")
  (sps:pp::print c)
  (sps:pp::newline)
  (sps:lexer:lex lexer sps:pp::actions state))

(define (sps:pp::end lexer state line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " EOI" )
  (sps:pp::newline))


(define-static-vector sps:pp::actions
  (sps:pp::str
   sps:pp::str-chunk
   sps:pp::id
   sps:pp::id-chunk
   sps:pp::list-open
   sps:pp::list-close
   sps:pp::int
   sps:pp::boolean
   sps:pp::char
   sps:pp::end))

(define (sps:pp::bad-char lexer char line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - bad char ") 
  (sps:pp::print char)
  (sps:pp::newline))

(define (sps:pp::unterminated-str lexer line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - unterminated str ")
  (sps:pp::newline))

(define (sps:pp::sign-no-digit lexer line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - sign but no digit ")
  (sps:pp::newline))

(define (sps:pp::lonely-hash lexer line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - unterminated #")
  (sps:pp::newline))

(define (sps:pp::bad-boolean lexer v c line start-column column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - badly terminated boolean ")
  (sps:pp::print c)
  (sps:pp::newline))

(define (sps:pp::radix-no-digit lexer radix line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - missing digits in # ")
  (sps:pp::print radix) 
  (sps:pp::newline))

(define (sps:pp::unterminated-char lexer line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - unterminated char ")
  (sps:pp::newline))

(define (sps:pp::xxx-char lexer char start-column line column)
  (sps:pp::print-pos line column)
  (sps:pp::print " ERROR - badly terminated char ")
  (sps:pp::print char)
  (sps:pp::newline))

(define-static-vector sps:pp::errors
  (sps:pp::bad-char
   sps:pp::unterminated-str
   sps:pp::sign-no-digit
   sps:pp::lonely-hash
   sps:pp::bad-boolean
   sps:pp::radix-no-digit
   sps:pp::unterminated-char
   sps:pp::xxx-char))
