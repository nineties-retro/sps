;
; Uses sps:lexer:lex to build an AST for Scheme.
; This version tail-calls sps:lexer:lex with each node it creates rather
; than returning it.
;

(define (sps:ast::print:string string)
  (sps:io:print:string (sps:io:stdout) string))

(define (sps:ast::print:int int)
  (sps:io:print:int (sps:io:stdout) int))

(define (sps:ast::print:char c)
  (sps:io:print:char (sps:io:stdout) c))

(define (sps:ast::newline)
  (sps:io:newline (sps:io:stdout)))

(define sps:ast::kind-int   1)
(define sps:ast::kind-id    2)
(define sps:ast::kind-str   3)
(define sps:ast::kind-char  4)
(define sps:ast::kind-bool  5)
(define sps:ast::kind-list  6)
(define sps:ast::kind-dummy 7)

                           ; SPSASTND
(define sps:ast::tag-value #x565A572D)

(define (sps:ast::tag n)
  (sps:word-vector:ref  n 0))
(define (sps:ast::tag! n v)
  (sps:word-vector:set! n 0 v))

(define (sps:ast? t) 
  (= (sps:ast::tag t) sps:ast::tag-value))

(define (sps:ast::kind n)
  (sps:assert (sps:ast? n))
  (sps:word-vector:ref  n 1))
(define (sps:ast::kind! n v)
  (sps:assert (sps:ast? n))
  (sps:word-vector:set! n 1 v))

(define (sps:ast:value n)
  (sps:assert (sps:ast? n))
  (sps:word-vector:ref  n 2))
(define (sps:ast::value! n v)
  (sps:assert (sps:ast? n))
  (sps:word-vector:set! n 2 v))

(define (sps:ast:next n)
  (sps:assert (sps:ast? n))
  (sps:word-vector:ref  n 3))
(define (sps:ast::next! n v)
  (sps:assert (sps:ast? n))
  (sps:word-vector:set! n 3 v))

(define (sps:ast:line n)
  (sps:assert (sps:ast? n))
  (sps:word-vector:ref  n 4))
(define (sps:ast::line! n v)
  (sps:assert (sps:ast? n))
  (sps:word-vector:set! n 4 v))

(define (sps:ast:column n)
  (sps:assert (sps:ast? n))
  (sps:word-vector:ref  n 5))
(define (sps:ast::column! n v)
  (sps:assert (sps:ast? n))
  (sps:word-vector:set! n 5 v))

(define sps:ast::size (* 6 sps:bytes-per-word))

                                 ; SPSASTST
(define sps:ast::state:tag-value #x565A5757)

(define (sps:ast::state:tag s)
  (sps:word-vector:ref  s 0))
(define (sps:ast::state:tag! s v)
  (sps:word-vector:set! s 0 v))

(define (sps:ast::state? t) 
  (= (sps:ast::state:tag t) sps:ast::state:tag-value))

(define (sps:ast::state:id-chunk? s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 1))
(define (sps:ast::state:id-chunk! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 1 v))

(define (sps:ast::state:str-chunk? s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 2))
(define (sps:ast::state:str-chunk! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 2 v))

(define (sps:ast::state:root s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 3))
(define (sps:ast::state:root! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 3 v))

(define (sps:ast::state:node s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 4))
(define (sps:ast::state:node! s n)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 4 n))

(define (sps:ast::state:strings s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 5))
(define (sps:ast::state:strings! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 5 v))

(define (sps:ast::state:hash-table s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 6))
(define (sps:ast::state:hash-table! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 6 v))

(define (sps:ast::state:hash-value s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 7))
(define (sps:ast::state:hash-value! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 7 v))

(define (sps:ast::state:stack-pool s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 8))
(define (sps:ast::state:stack-pool! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 8 v))

(define (sps:ast::state:node-pool s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 9))
(define (sps:ast::state:node-pool! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 9 v))

(define (sps:ast::state:pools s)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:ref  s 10))
(define (sps:ast::state:pools! s v)
  (sps:assert (sps:ast::state? s))
  (sps:word-vector:set! s 10 v))

(define sps:ast::state:size (* 11 sps:bytes-per-word))


(define (sps:ast::init-node! node kind value next line column)
  (sps:ast::tag! node sps:ast::tag-value)
  (sps:ast::kind! node kind)
  (sps:ast::value! node value)
  (sps:ast::next! node next)
  (sps:ast::line! node line)
  (sps:ast::column! node column))

(define (sps:ast::build-node state kind value next line column)
  (let* ((node-pool (sps:ast::state:node-pool state))
         (node (sps:mem:fsp:alloc node-pool sps:ast::size sps:bytes-per-word)))
    (sps:and node (sps:ast::init-node! node kind value next line column))
    node))

(define (sps:ast::int state v line column)
  (sps:ast::build-node state sps:ast::kind-int v #f line column))

(define (sps:ast::bool state b line column)
  (sps:ast::build-node state sps:ast::kind-bool b #f line column))

(define (sps:ast::char state c line column)
  (sps:ast::build-node state sps:ast::kind-char c #f line column))

(define (sps:ast::id state id line column)
  (sps:ast::build-node state sps:ast::kind-id id #f line column))

(define (sps:ast::str state str line column)
  (sps:ast::build-node state sps:ast::kind-str str #f line column))

(define (sps:ast::list state child line column)
  (sps:ast::build-node state sps:ast::kind-list child #f line column))

(define (sps:ast::dummy state)
  (sps:ast::build-node state sps:ast::kind-dummy 0 #f 0 0))

(define (sps:ast::open-strings state)
  (let* ((sp (sps:ast::state:stack-pool state))
         (pools (sps:ast::state:pools state))
         (strs (sps:mem:sp:alloc sp sps:strings:size sps:bytes-per-word)))
    (sps:and strs
             (sps:strings:open strs pools) 
             (sps:ast::state:strings! state strs)
             #t)))

(define (sps:ast::close-strings state)
  (sps:strings:close (sps:ast::state:strings state)))

(define (sps:ast::open-dummy state)
  (let ((dummy (sps:ast::dummy state)))
    (sps:and
      dummy
      (begin
        (sps:ast::state:root! state dummy)
        (sps:ast::state:node! state dummy)
        #t))))

(define (sps:ast::close-dummy state)
  (let ((node-pool (sps:ast::state:node-pool state))
        (dummy (sps:ast::state:root state)))
    (sps:mem:fsp:free node-pool dummy)))


(define (sps:ast::open-node-pool state)
  (let* ((pools (sps:ast::state:pools state))
         (node-pool (sps:mem:fsp:open pools sps:ast::size sps:bytes-per-word)))
    (sps:and 
      node-pool
      (sps:ast::state:node-pool! state node-pool)
      #t)))

(define (sps:ast::close-node-pool state)
  (sps:mem:fsp:close (sps:ast::state:node-pool state)))


(define-static-vector sps:ast::open-actions
  (sps:ast::open-strings   sps:ast::close-strings
   sps:ast::open-node-pool sps:ast::close-node-pool
   sps:ast::open-dummy     sps:ast::close-dummy))

(define sps:ast::n-open-actions 3)

(define (sps:ast::state-undo-actions state n)
  (let loop ((i n))
    (if (>= i 0)
        (let ((action (sps:word-vector:ref sps:ast::open-actions i)))
          (action state)
          (loop (- i 2)))
        #f)))

(define (sps:ast::state-do-actions state n)
  (let loop ((i 0))
    (or 
      (= i n)
      (let* ((action (sps:word-vector:ref sps:ast::open-actions i)))
        (if (action state)
            (loop (+ i 2))
            (sps:ast::state-undo-actions state (- i 1)))))))

(define (sps:ast::state-open state pools hash-table)
  (let ((sp (sps:mem:sp:obtain pools)))
    (sps:and 
     sp
     (begin
       (sps:ast::state:tag! state sps:ast::state:tag-value)
       (sps:ast::state:pools! state pools)
       (sps:ast::state:stack-pool! state sp)
       (sps:ast::state:hash-table! state hash-table)
       (sps:ast::state:id-chunk! state #f)
       (sps:ast::state:str-chunk! state #f)
       (sps:ast::state:hash-value! state 0)
       (sps:ast::state-do-actions state (* 2 sps:ast::n-open-actions))))))



(define (sps:ast::hash-complete-id state buffer start end)
  (let* ((strings (sps:ast::state:strings state))
         (hash-table (sps:ast::state:hash-table state))
         (hv (sps:hash:string 0 buffer start end))
         (node (sps:hash-table:enter hash-table buffer start end hv)))
    (sps:and
      node
      (if (sps:hash-table:node:new? node)
          (let ((s (sps:strings:add+commit strings buffer start end)))
            (sps:hash-table:node:string! node s)
            s)
          (sps:hash-table:node:string node)))))


(define (sps:ast::hash-chunked-id state buffer start end)
  (let* ((strings (sps:ast::state:strings state))
         (hash-table (sps:ast::state:hash-table state))
         (h0 (sps:ast::state:hash-value state))
         (hv (sps:hash:string h0 buffer start end))
         (id-str (sps:strings:add strings buffer start end)))
    (sps:and
      id-str
      (let* ((id-start (sps:strings:string:start id-str))
             (id-lit   (sps:strings:string:literal id-str))
             (id-end   (sps:strings:string:end id-str))
             (node (sps:hash-table:enter hash-table id-lit id-start id-end hv)))
        (sps:and
          node
          (begin
            (sps:ast::state:id-chunk!   state #f)
            (sps:ast::state:hash-value! state 0)
            (if (sps:hash-table:node:new? node)
                (let ((s (sps:strings:commit strings)))
                  (sps:hash-table:node:string! node s)
                  s)
                (begin
                  (sps:strings:release strings)
                  (sps:hash-table:node:string node)))))))))


(define (sps:ast::hash-id state buffer start end)
  (if (sps:ast::state:id-chunk? state)
      (sps:ast::hash-chunked-id state buffer start end)
      (sps:ast::hash-complete-id state buffer start end)))


(define-forward sps:ast::actions)


(define (sps:ast::build-id lexer state buffer start end line column)
  (let* ((id-str (sps:ast::hash-id state buffer start end))
         (node (sps:ast::state:node state))
         (id (sps:ast::id state id-str line column)))
    (sps:ast::next! node id)
    (sps:ast::state:node! state id)
    (sps:and id-str id (sps:lexer:lex lexer sps:ast::actions state))))

(define (sps:ast::build-id-chunk lexer state buffer start end line column)
  (let* ((strings (sps:ast::state:strings state))
         (h0 (sps:ast::state:hash-value state))
         (hash-value (sps:hash:string h0 buffer start end)))
    (sps:ast::state:hash-value! state hash-value)
    (sps:ast::state:id-chunk! state #t)
    (sps:strings:add strings buffer start end)))


(define (sps:ast::build-str lexer state buffer start end line column)
  (let* ((strings (sps:ast::state:strings state))
         (str-str (sps:strings:add+commit strings buffer start end))
         (node (sps:ast::state:node state))
         (str (sps:ast::str state str-str line column)))
    (sps:ast::state:str-chunk! state #f)
    (sps:ast::next! node str)
    (sps:ast::state:node! state str)
    (sps:and str-str str (sps:lexer:lex lexer sps:ast::actions state))))

(define (sps:ast::build-str-chunk lexer state buffer start end line column)
  (let ((strings (sps:ast::state:strings state)))
    (sps:ast::state:str-chunk! state #t)
    (sps:strings:add strings buffer start end)))

(define (sps:ast::build-list-open lexer state line column)
  (let* ((node (sps:ast::state:node state))
         (dummy (sps:ast::dummy state))
         (node-pool (sps:ast::state:node-pool state)))
    (sps:and
      dummy
      (begin
        (sps:ast::state:node! state dummy)
        (let* ((lr (sps:lexer:lex lexer sps:ast::actions state))
               (child (sps:ast:next dummy))
               (list (sps:ast::list state child line column)))
          (sps:ast::next! node list)
          (sps:ast::state:node! state list)
          (sps:mem:fsp:free node-pool dummy)
          (sps:and lr list (sps:lexer:lex lexer sps:ast::actions state)))))))

(define (sps:ast::build-list-close lexer state line column)
  #t)

(define (sps:ast::build-int lexer state i line column)
  (let ((int (sps:ast::int state i line column))
        (node (sps:ast::state:node state)))
    (sps:ast::next! node int)
    (sps:ast::state:node! state int)
    (sps:and int (sps:lexer:lex lexer sps:ast::actions state))))

(define (sps:ast::build-bool lexer state b line column)
  (let ((bool (sps:ast::bool state b line column))
        (node (sps:ast::state:node state)))
    (sps:ast::next! node bool)
    (sps:ast::state:node! state bool)
    (sps:and bool (sps:lexer:lex lexer sps:ast::actions state))))

(define (sps:ast::build-char lexer state char line column)
  (let ((char (sps:ast::char state char line column))
        (node (sps:ast::state:node state)))
    (sps:ast::next! node char)
    (sps:ast::state:node! state char)
    (sps:and char (sps:lexer:lex lexer sps:ast::actions state))))

(define (sps:ast::build-end lexer state line column)
  (let ((dummy-root (sps:ast::state:root state))
        (node-pool (sps:ast::state:node-pool state)))
    (let ((new-root (sps:ast:next dummy-root)))
      (sps:ast::state:root! state new-root)
      (sps:mem:fsp:free node-pool dummy-root)
      state)))

(define (sps:ast::print:pos l c)
  (let ((op (sps:io:stdout)))
    (sps:and
      (sps:io:print:string op "[")
      (sps:io:print:int op l)
      (sps:io:print:string op ",")
      (sps:io:print:int op c)
      (sps:io:print:string op "]"))))


(define (sps:ast::bad-char lexer char line column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - bad char ") 
  (sps:ast::print:char char)
  (sps:ast::newline)
  #f)


(define (sps:ast::runaway-str lexer line column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - unterminated str ")
  (sps:ast::newline)
  #f)

(define (sps:ast::sign-no-digit lexer line column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - sign but no digit ")
  (sps:ast::newline)
  #f)

(define (sps:ast::lonely-hash lexer line column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - unterminated #")
  (sps:ast::newline)
  #f)

(define (sps:ast::bad-boolean lexer v c line start-column column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - badly terminated boolean ")
  (sps:ast::print:char c)
  (sps:ast::newline)
  #f)

(define (sps:ast::radix-no-digit lexer radix line column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - missing digits in # ")
  (sps:ast::print:int radix) 
  (sps:ast::newline)
  #f)

(define (sps:ast::unterminated-char lexer line column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - unterminated char ")
  (sps:ast::newline)
  #f)

(define (sps:ast::xxx-char lexer char start-column line column)
  (sps:ast::print:pos line column)
  (sps:ast::print:string " ERROR - badly terminated char ")
  (sps:ast::print:char char)
  (sps:ast::newline)
  #f)

(define-static-vector sps:ast::errors
  (sps:ast::bad-char
   sps:ast::runaway-str
   sps:ast::sign-no-digit
   sps:ast::lonely-hash
   sps:ast::bad-boolean
   sps:ast::radix-no-digit
   sps:ast::unterminated-char
   sps:ast::xxx-char))



(define-static-vector sps:ast::actions
  (sps:ast::build-str
   sps:ast::build-str-chunk
   sps:ast::build-id
   sps:ast::build-id-chunk
   sps:ast::build-list-open
   sps:ast::build-list-close
   sps:ast::build-int
   sps:ast::build-bool
   sps:ast::build-char
   sps:ast::build-end))


(define (sps:ast lexer state)
  (sps:lexer:lex lexer sps:ast::actions state))


(define (sps:ast::fold int id str char bool list state node)
  (sps:and
    node
    (let ((kind (sps:ast::kind node))
          (value (sps:ast:value node)))
      (cond ((= kind sps:ast::kind-int) (int node value state))
            ((= kind sps:ast::kind-id)  (id node value state))
            ((= kind sps:ast::kind-str) (str node value state))
            ((= kind sps:ast::kind-char) (char node value state))
            ((= kind sps:ast::kind-bool) (bool node value state))
            ((= kind sps:ast::kind-list) (list node value state))))))

(define (sps:ast::list-fold f state ast)
  (let loop ((node ast))
    (sps:and node (f state (sps:ast:value node)) (loop (sps:ast:next node)))))
