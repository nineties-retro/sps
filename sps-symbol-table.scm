; SPS symbol table.
;
; SPS has nested scopes but they cannot be referred to from outside
; themselves (i.e. SPS has no records or modules).  Consequently there
; is no need to explicitly store the bindings once a scope has been 
; exited.  This fact is taken advantage of in the following which uses
; a very simple linear list to hold all the bindings -- something more
; efficient can wait until the there is a working system.
;
; It relies on each node in the symbol containing at least the following
; three fields :-
;
;   +---+
;   |   | next-binding
;   +---+
;   |   | identifier
;   +---+
;   |   | next-scope
;   +---+
;
; next-binding points to the next binding in the same scope.
; next-scope points to the (last) binding in the next (enclosing) scope.
;
; For example, consider the following :-
;
;  (define (f a b)
;    (let ((x (+ a b))
;          (y (- a b))
;          (z (* a b))
;      here
;
; at the point "here", the structure would look like :-
;
;    here                    dummy node that terminates a scope
;     |                          |                          |                  
;     v                          v                          v      
;   +---+    +---+    +---+    +---+    +---+    +---+    +---+    +---+
;   |   |--->|   |--->|   |--->|   |--->|   |--->|   |--->|   |--->|   |
;   +---+    +---+    +---+    +---+    +---+    +---+    +---+    +---+
;   | z |    | y |    | x |    |   |    | b |    | a |    |   |    | f |
;   +---+    +---+    +---+    +---+    +---+    +---+    +---+    +---+
;   |   |-+  |   |-+  |   |-+->|   |    |   |-+  |   |-+->|   |    |   |
;   +---+ |  +---+ |  +---+ |  +---+    +---+ |  +---+ |  +---+    +---+
;         |        |        |                 |        |         
;         +--->----+---->---+                 +--------+          
;

                                          ; SPSSTNXX
(define sps:symbol-table::node::tag-value #x56557288)

(define (sps:symbol-table::node:tag  n)
  (sps:word-vector:ref  n 0))
(define (sps:symbol-table::node:tag! n v)
  (sps:word-vector:set! n 0 v))

(define (sps:symbol-table::node? t) 
  (= (sps:symbol-table::node:tag t) sps:symbol-table::node::tag-value))

(define (sps:symbol-table:node:id n)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:ref  n 1))
(define (sps:symbol-table::node:id! n v)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:set! n 1 v))

(define (sps:symbol-table:node:source n)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:ref  n 2))
(define (sps:symbol-table::node:source! n v)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:set! n 2 v))

(define (sps:symbol-table:node:value n)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:ref  n 3))
(define (sps:symbol-table:node:value! n v)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:set! n 3 v))

(define (sps:symbol-table::node:next-binding n)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:ref  n 4))
(define (sps:symbol-table::node:next-binding! n v)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:set! n 4 v))

(define (sps:symbol-table::node:enclosing-scope n)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:ref  n 5))
(define (sps:symbol-table::node:enclosing-scope! n v)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:set! n 5 v))

(define (sps:symbol-table:node:unique-id n)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:ref  n 6))
(define (sps:symbol-table::node:unique-id! n v)
  (sps:assert (sps:symbol-table::node? n))
  (sps:word-vector:set! n 6 v))

(define sps:symbol-table::node:size (* 7 sps:bytes-per-word))


                                    ; SPSSTTVX
(define sps:symbol-table::tag-value #x565577C8)

(define (sps:symbol-table::tag  n)
  (sps:word-vector:ref  n 0))
(define (sps:symbol-table::tag! n v)
  (sps:word-vector:set! n 0 v))

(define (sps:symbol-table? t) 
  (= (sps:symbol-table::tag t) sps:symbol-table::tag-value))

(define (sps:symbol-table::bindings n)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:ref  n 1))
(define (sps:symbol-table::bindings! n v)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:set! n 1 v))

(define (sps:symbol-table::current-scope n)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:ref  n 2))
(define (sps:symbol-table::current-scope! n v)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:set! n 2 v))

(define (sps:symbol-table::pools n)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:ref  n 3))
(define (sps:symbol-table::pools! n v)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:set! n 3 v))

(define (sps:symbol-table::node-pool n)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:ref  n 4))
(define (sps:symbol-table::node-pool! n v)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:set! n 4 v))

(define (sps:symbol-table::unique-id n)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:ref  n 5))
(define (sps:symbol-table::unique-id! n v)
  (sps:assert (sps:symbol-table? n))
  (sps:word-vector:set! n 5 v))

(define sps:symbol-table:size (* 6 sps:bytes-per-word))

(define (sps:symbol-table::dump st)
  (let ((op (sps:io:stdout)))
    (sps:and
      (sps:io:print:string op "SYMBOL-TABLE ")
      (sps:io:newline op)
      (let loop ((binding (sps:symbol-table::bindings st)))
        (sps:and 
          binding 
          (let ((id (sps:symbol-table:node:id binding)))
            (sps:and
              (sps:io:print:string op "  ID        = ")
              (if id 
                  (sps:io:print:string op id)
                  (sps:io:print:string op ".scope."))))
          (sps:io:newline op)
          (sps:io:print:string op "  UNIQUE ID = ")
          (sps:io:print:int op (sps:symbol-table:node:unique-id binding))
          (sps:io:newline op)
          (loop (sps:symbol-table::node:next-binding binding)))))))


;
; Returns a non-zero value if the node has just been allocated.
; It is assumed that this will be called just after a node is
; returned by sps:symbol-table:enter.
;
(define (sps:symbol-table:node:new? node)
  (not (sps:symbol-table:node:value node)))


;
; Open a new symbol table.  Returns a non-zero value if the symbol
; table is opened successfully otherwise 0 is returned.
;
(define (sps:symbol-table:open table pools)
  (let* ((alignment sps:bytes-per-word)
         (size sps:symbol-table::node:size)
         (np (sps:mem:fsp:open pools size alignment)))
    (sps:and
      np
      (begin
        (sps:symbol-table::tag! table sps:symbol-table::tag-value)
        (sps:symbol-table::node-pool! table np)
        (sps:symbol-table::pools! table pools)
        (sps:symbol-table::bindings! table 0)
        (sps:symbol-table::unique-id! table 0)
        (sps:symbol-table::current-scope! table 0)))
    np))

;
; Lookup the identifier in the symbol table.  If the identifier is in the
; symbol table then the sps:symbol-table:node that contains it is returned.
; If the symbol table does not contain the identifier then 0 is returned.
;
(define (sps:symbol-table:lookup st id)
  (let loop ((binding (sps:symbol-table::bindings st)))
    (sps:and
      binding
      (if (eq? id (sps:symbol-table:node:id binding))
          binding
          (loop (sps:symbol-table::node:next-binding binding))))))


(define (sps:symbol-table::make-node st id id-node current-scope next-binding)
  (let ((node-pool (sps:symbol-table::node-pool st))
        (size sps:symbol-table::node:size)
        (alignment sps:bytes-per-word)
        (unique-id (sps:symbol-table::unique-id st)))
    (let ((node (sps:mem:fsp:alloc node-pool size alignment)))
      (sps:and
        node
        (begin
          (sps:symbol-table::node:tag! node sps:symbol-table::node::tag-value)
          (sps:symbol-table::node:next-binding! node next-binding)
          (sps:symbol-table::node:id! node id)
          (sps:symbol-table:node:value! node #f)
          (sps:symbol-table::node:source! node id-node)
          (sps:symbol-table::node:enclosing-scope! node current-scope)
          (sps:symbol-table::node:unique-id! node unique-id)
          (sps:symbol-table::unique-id! st (+ 1 unique-id))
          (sps:symbol-table::bindings! st node)
          (sps:symbol-table::current-scope! st node)))
      node)))


;
; Enter an identifier into the symbol table (also takes the node that
; contains the identifier so that it is possible to issue error messages
; about the identifier).
;
; Returns a sps:symbol-table:node.  If the identifier is already in
; the symbol table then the node containing that identifier is returned.
; If the identifier is not already in the symbol table then a new node
; is allocated and the id is put in the symbol table node.  If a new
; node cannot be created then 0 is returned.  It is possible to tell
; the difference between a new node and an old node by applying
; sps:symbol-table:node:new? to it.
;
(define (sps:symbol-table:enter st id id-node)
  (let ((latest-binding (sps:symbol-table::bindings st)))
    (let loop ((b latest-binding))
      (sps:if (sps:and b (sps:symbol-table::node:enclosing-scope b))
              (if (eq? id (sps:symbol-table:node:id b))
                  b
                  (loop (sps:symbol-table::node:next-binding b)))
              (let ((cs (sps:symbol-table::current-scope st)))
                (sps:symbol-table::make-node st id id-node cs latest-binding))))))


;
; Open a new scope.  Returns a non-zero value if the scope was 
; successfully opened otherwise returns 0.
;
(define (sps:symbol-table:open-scope st)
  (sps:symbol-table::make-node st 0 0 0 (sps:symbol-table::bindings st)))


;
; Close the current scope.  This has the effect of removing all the bindings
; in the current scope and setting the current scope to the enclosing scope
; of the current scope.
;
(define (sps:symbol-table:close-scope st)
  (let ((node-pool (sps:symbol-table::node-pool st)))
    (let loop ((binding (sps:symbol-table::bindings st)))
      (let ((nb (sps:symbol-table::node:next-binding binding)))
        (sps:if (sps:symbol-table::node:enclosing-scope binding)
                (begin
                  (sps:mem:fsp:free node-pool binding)
                  (loop nb))
                (begin
                  (sps:mem:fsp:free node-pool binding)
                  (sps:symbol-table::bindings! st nb)
                  (sps:symbol-table::current-scope! st nb)))))))
