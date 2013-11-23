; To avoid hard-coding what the lexer should do when it finds each lexeme
; the lexer is parameterized over the actions it should perform.
; In design pattern speak, this is an instance of a Builder (see
; Gamma et al. page 97)

(define (sps:lexer:action:str ops)
  (sps:word-vector:ref ops 0))

(define (sps:lexer:action:str-chunk ops)
  (sps:word-vector:ref ops 1))

(define (sps:lexer:action:id ops)
  (sps:word-vector:ref ops 2))

(define (sps:lexer:action:id-chunk ops)
  (sps:word-vector:ref ops 3))

(define (sps:lexer:action:list-open ops)
  (sps:word-vector:ref ops 4))

(define (sps:lexer:action:list-close ops)
  (sps:word-vector:ref ops 5))

(define (sps:lexer:action:int ops)
  (sps:word-vector:ref ops 6))

(define (sps:lexer:action:boolean ops)
  (sps:word-vector:ref ops 7))

(define (sps:lexer:action:char ops)
  (sps:word-vector:ref ops 8))

(define (sps:lexer:action:end ops)
  (sps:word-vector:ref ops 9))
