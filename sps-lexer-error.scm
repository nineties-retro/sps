(define (sps:lexer:error:bad-char ops) 
  (sps:word-vector:ref ops 0))

(define (sps:lexer:error:runaway-str ops)
  (sps:word-vector:ref ops 1))

(define (sps:lexer:error:sign-no-digit ops)
  (sps:word-vector:ref ops 2))

(define (sps:lexer:error:lonely-hash ops)
  (sps:word-vector:ref ops 3))

(define (sps:lexer:error:bad-boolean ops)
  (sps:word-vector:ref ops 4))

(define (sps:lexer:error:radix-no-digit ops)
  (sps:word-vector:ref ops 5))

(define (sps:lexer:error:unterminated-char ops)
  (sps:word-vector:ref ops 6))

(define (sps:lexer:error:xxx-char ops)
  (sps:word-vector:ref ops 7))
