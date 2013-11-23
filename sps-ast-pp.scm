(define (sps:ast::fold int id str char bool list state root)
  (and root
       (let ((tag (sps:ast::kind root)))
         (cond ((= tag sps:ast::kind-int)
                (sps:ast::fold int id str char bool list 
                               (int (sps:ast::value root) state)
                               (sps:ast:next root)))
               ((= tag sps:ast::kind-id)
                (sps:ast::fold int id str char bool list
                               (id (sps:ast::value root) state)
                               (sps:ast:next root)))
               ((= tag sps:ast::kind-str)
                (sps:ast::fold int id str char bool list
                               (str (sps:ast::value root) state)
                               (sps:ast:next root)))
               ((= tag sps:ast::kind-char)
                (sps:ast::fold int id str char bool list 
                               (char (sps:ast::value root) state)
                               (sps:ast:next root)))
               ((= tag sps:ast::kind-bool)
                (sps:ast::fold int id str char bool list
                               (bool (sps:ast::value root) state)
                               (sps:ast:next root)))
               ((= tag sps:ast::kind-list)
                (sps:ast::fold int id str char bool list
                               (list (sps:ast::value root) state)
                               (sps:ast:next root)))))))
                

(define (sps:ast::pp-int i s)
  (display i)
  (newline)
  s)

(define (sps:ast::pp-id i s)
  (display i)
  (newline)
  s)

(define (sps:ast::pp-str i s)
  (display i)
  (newline)
  s)

(define (sps:ast::pp-char c s)
  (display i)
  (newline)
  s)

(define (sps:ast::pp-bool b s)
  (display b)
  (newline)
  s)

(define (sps:ast::pp:indent n)
  (let loop ((i 0))
    (or (= i n) (begin (display #\space) (loop (+ i 1))))))

(define (sps:ast::pp-list l s)
  ;(sps:ast::pp:indent s)
  (display #\()
  (newline)
  (sps:ast-pp l (+ s 2))
  (display #\))
  (newline)
  s)

(define (sps:ast-pp root s)
  (sps:ast::fold sps:ast::pp-int sps:ast::pp-id sps:ast::pp-str
                 sps:ast::pp-char sps:ast::pp-bool sps:ast::pp-list s root))
