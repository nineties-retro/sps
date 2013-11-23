;
; SPS to (GNU) C translator.
;

                                ; SPS2CSTE
(define sps->c::state:tag-value #x5652C57E)

(define (sps->c::state:tag s)
  (sps:word-vector:ref  s 0))
(define (sps->c::state:tag! s v)
  (sps:word-vector:set! s 0 v))

(define (sps->c::state? t) 
  (= (sps->c::state:tag t) sps->c::state:tag-value))

(define (sps->c::state:hash-table s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 1))
(define (sps->c::state:hash-table! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 1 v))

(define (sps->c::state:symbol-table s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 2))
(define (sps->c::state:symbol-table! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 2 v))

(define (sps->c::state:stack-pool s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 3))
(define (sps->c::state:stack-pool! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 3 v))

(define (sps->c::state:preamble-port s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 4))
(define (sps->c::state:preamble-port! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 4 v))

(define (sps->c::state:main-port s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 5))
(define (sps->c::state:main-port! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 5 v))

(define (sps->c::state:top-level? s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 6))
(define (sps->c::state:top-level! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 6 v))

(define (sps->c::state:string-literal-count s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 7))
(define (sps->c::state:string-literal-count! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 7 v))

(define (sps->c::state:binding-depth s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 8))
(define (sps->c::state:binding-depth! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 8 v))

(define (sps->c::state:forward-val-decl s)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:ref  s 9))
(define (sps->c::state:forward-val-decl! s v)
  (sps:assert (sps->c::state? s))
  (sps:word-vector:set! s 9 v))

(define sps->c:state:size (* 10 sps:bytes-per-word))


                               ; SPS2CEPX
(define sps->c::proc:tag-value #x5652CE68)

(define (sps->c::proc:tag s)
  (sps:word-vector:ref  s 0))
(define (sps->c::proc:tag! s v)
  (sps:word-vector:set! s 0 v))

(define (sps->c::proc? t) 
  (= (sps->c::proc:tag t) sps->c::proc:tag-value))

(define (sps->c::proc:args s)
  (sps:assert (sps->c::proc? s))
  (sps:word-vector:ref  s 1))
(define (sps->c::proc:args! s v)
  (sps:assert (sps->c::proc? s))
  (sps:word-vector:set! s 1 v))

(define (sps->c::proc:n-args s)
  (sps:assert (sps->c::proc? s))
  (sps:word-vector:ref  s 2))
(define (sps->c::proc:n-args! s v)
  (sps:assert (sps->c::proc? s))
  (sps:word-vector:set! s 2 v))

(define (sps->c::proc:forward? s)
  (sps:assert (sps->c::proc? s))
  (sps:word-vector:ref  s 3))
(define (sps->c::proc:forward! s v)
  (sps:assert (sps->c::proc? s))
  (sps:word-vector:set! s 3 v))

(define sps->c::proc:size (* 4 sps:bytes-per-word))


                              ; SPS2CEVX
(define sps->c::val:tag-value #x5652CEC8)

(define (sps->c::val:tag s)
  (sps:word-vector:ref  s 0))
(define (sps->c::val:tag! s v)
  (sps:word-vector:set! s 0 v))

(define (sps->c::val? t) 
  (= (sps->c::val:tag t) sps->c::val:tag-value))

(define (sps->c::val:forward? s)
  (sps:assert (sps->c::val? s))
  #t)

(define (sps->c::val:forward! s v)
  (sps:assert (sps->c::val? s))
  #t)

(define sps->c::val:size (* 1 sps:bytes-per-word))



                                 ; SPS2CESX
(define sps->c::syntax:tag-value #x5652CE58)

(define (sps->c::syntax:tag s)
  (sps:word-vector:ref  s 0))
(define (sps->c::syntax:tag! s v)
  (sps:word-vector:set! s 0 v))

(define (sps->c::syntax? t) 
  (= (sps->c::syntax:tag t) sps->c::syntax:tag-value))

(define (sps->c::syntax:transformer s)
  (sps:assert (sps->c::syntax? s))
  (sps:word-vector:ref  s 1))
(define (sps->c::syntax:transformer! s v)
  (sps:assert (sps->c::syntax? s))
  (sps:word-vector:set! s 1 v))

(define sps->c::syntax:size (* 2 sps:bytes-per-word))


                                   ; SPS2CELP
(define sps->c::let-proc:tag-value #x5652CE76)

(define (sps->c::let-proc:tag s)
  (sps:word-vector:ref  s 0))
(define (sps->c::let-proc:tag! s v)
  (sps:word-vector:set! s 0 v))

(define (sps->c::let-proc? t) 
  (= (sps->c::let-proc:tag t) sps->c::let-proc:tag-value))

(define (sps->c::let-proc:binding-depth s)
  (sps:assert (sps->c::let-proc? s))
  (sps:word-vector:ref  s 1))
(define (sps->c::let-proc:binding-depth! s v)
  (sps:assert (sps->c::let-proc? s))
  (sps:word-vector:set! s 1 v))

(define (sps->c::let-proc:n-args s)
  (sps:assert (sps->c::let-proc? s))
  (sps:word-vector:ref  s 2))
(define (sps->c::let-proc:n-args! s v)
  (sps:assert (sps->c::let-proc? s))
  (sps:word-vector:set! s 2 v))

(define sps->c::let-proc:size (* 3 sps:bytes-per-word))


(define sps->c::literal:and    (sps:static-string "and"))
(define sps->c::literal:begin  (sps:static-string "begin"))
(define sps->c::literal:case   (sps:static-string "case"))
(define sps->c::literal:cond   (sps:static-string "cond"))
(define sps->c::literal:define (sps:static-string "define"))

(define sps->c::literal:define-external (sps:static-string "define-external"))
(define sps->c::literal:define-forward (sps:static-string "define-forward"))

(define sps->c::literal:define-static-vector
  (sps:static-string "define-static-vector"))

(define sps->c::literal:else   (sps:static-string "else"))
(define sps->c::literal:if     (sps:static-string "if"))
(define sps->c::literal:let    (sps:static-string "let"))
(define sps->c::literal:let*   (sps:static-string "let*"))
(define sps->c::literal:or     (sps:static-string "or"))


(define (sps->c::list? n) (= sps:ast::kind-list (sps:ast::kind n)))
(define (sps->c::id? n) (= sps:ast::kind-id (sps:ast::kind n)))
(define (sps->c::int? n) (= sps:ast::kind-int (sps:ast::kind n)))

(define (sps->c::display-int  v port)
  (sps:io:print:int port v))

(define (sps->c::display-str  id port)
  (let ((lit (sps:string:literal id))
        (start (sps:string:start id))
        (end (sps:string:end id)))
    (sps:io:write-substring port lit start end)))

(define sps->c::display-id sps->c::display-str)

(define (sps->c::display-char v port)
  (sps:io:print:char port v))

(define (sps->c::display-bool v port)
  (sps:io:print:bool port v))

(define (sps->c::display-list v port)
  #t)


(define (sps->c::error:int-arg i)
  (sps:and
    (sps:io:print:string (sps:io:stdout) " int ")
    (sps->c::display-int i (sps:io:stdout))))

(define (sps->c::error:id-arg i)
  (sps:and
    (sps:io:print:string (sps:io:stdout) " id ")
    (sps->c::display-id i (sps:io:stdout))))

(define (sps->c::error:char-arg c)
  (sps:and
    (sps:io:print:string (sps:io:stdout) " char ")
    (sps->c::display-char c (sps:io:stdout))))

(define (sps->c::error:bool-arg b)
  (sps:and
    (sps:io:print:string (sps:io:stdout) " bool ")
    (sps->c::display-bool b (sps:io:stdout))))

(define (sps->c::error:str-arg s)
  (sps:and
    (sps:io:print:string (sps:io:stdout) " str ")
    (sps->c::display-str s (sps:io:stdout))))

(define (sps->c::error:list-arg l)
  (sps:io:print:string (sps:io:stdout) " list "))

(define (sps->c::error:int-node int-node int ignore)
  (sps->c::error:int-arg int))
(define (sps->c::error:id-node id-node id ignore)
  (sps->c::error:id-arg id))
(define (sps->c::error:char-node char-node char ignore)
  (sps->c::error:char-arg char))
(define (sps->c::error:str-node str-node str ignore)
  (sps->c::error:str-arg str))
(define (sps->c::error:bool-node bool-node bool ignore)
  (sps->c::error:bool-arg bool))
(define (sps->c::error:list-node list-node list ignore)
  (sps->c::error:list-arg list))

(define (sps->c::error:start node key)
  (let ((op (sps:io:stdout)))
    (sps:and
      (sps:io:print:string op "sps->c error ")
      (sps:io:print:int op (sps:ast:line node))
      (sps:io:print:string op " ")
      (sps:io:print:int op (sps:ast:column node))
      (sps:io:print:string op " ")
      (sps:io:print:string op key))))

(define (sps->c::error:node-arg n) 
  (let ((op (sps:io:stdout)))
    (sps:and
      (sps:io:print:string op " ")
      (sps:io:print:int op (sps:ast:line n))
      (sps:io:print:string op " ")
      (sps:io:print:int op (sps:ast:column n))
      (sps:ast::fold sps->c::error:int-node  sps->c::error:id-node
                     sps->c::error:char-node sps->c::error:str-node
                     sps->c::error:bool-node sps->c::error:list-node
                     op n))))

(define (sps->c::error:end)
  (sps:io:newline (sps:io:stdout))
  #f)



(define (sps->c::error-if-not-id node state)
  (sps:or 
    (sps:and node (sps->c::id? node))
    (begin
      (sps->c::error:start node "expected_id")
      (sps->c::error:node-arg node)
      (sps->c::error:end))))


(define (sps->c::error-if-not-list node state)
  (sps:or 
    (sps:and node (sps->c::list? node))
    (begin
      (sps->c::error:start node "expected_list")
      (sps->c::error:node-arg node)
      (sps->c::error:end))))

(define (sps->c::specific-syntax? node expected-syntax)
  (and
    (sps->c::id? node)
    (let ((id (sps:ast:value node)))
      (eq? id expected-syntax))))

(define (sps->c::error-if-not-syntax node state expected-syntax)
  (sps:or 
    (sps:and node (sps->c::specific-syntax? node expected-syntax))
    (begin
      (sps->c::error:start node "expected_syntax")
      (sps->c::error:id-arg expected-syntax)
      (sps->c::error:node-arg node)
      (sps->c::error:end))))

(define (sps->c::do-expr-int int-node int state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:io:print:int mp int)))

(define (sps->c::output-generated-id id port)
  (sps:and
    (sps:io:print:string port "sps_g")
    (sps:io:print:int port id)))

(define (sps->c::do-expr-id id-node id state)
  (let ((st (sps->c::state:symbol-table state))
        (mp (sps->c::state:main-port state)))
    (let ((st-node (sps:symbol-table:lookup st id)))
      (sps:if st-node
          (let ((gid (sps:symbol-table:node:unique-id st-node)))
            (sps:and 
              (sps->c::output-generated-id gid mp)
              (sps:symbol-table:node:value st-node)))
          (begin
            (sps->c::error:start id-node "undefined_id")
            (sps->c::error:node-arg id-node)
            (sps->c::error:end))))))

(define (sps->c::do-expr-char char-node char-code state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:io:print:char mp char-code)))


(define (sps->c::pack-string-tail str pp n-bytes)
  (let* ((len (sps:strings:string:length str))
         (lit (sps:strings:string:literal str))
         (start (sps:strings:string:start str)))
    (let loop ((i 0) (o (- len 1)) (v 0))
      (if (not (= i n-bytes))
          (let ((c (sps:byte-vector:ref lit o)))
            (loop (+ i 1) (- o 1) (+ (* 256 v) c)))
          (sps:and
            (sps:io:print:string pp ",")
            (sps:io:print:hex-int pp v))))))
         

(define (sps->c::pack-string str pp)
  (let* ((len (sps:strings:string:length str))
         (lit (sps:strings:string:literal str))
         (start (sps:strings:string:start str))
         (n-words (quotient len sps:bytes-per-word))
         (n-bytes (remainder len sps:bytes-per-word)))
    (sps:and
      (sps:io:print:int pp len)
      (let loop ((i 0) (o start))
        (if (< i n-words)
            (sps:and
              (sps:io:print:string pp ",")
              (sps:io:print:hex-int pp (sps:byte-vector:unpack-word lit o))
              (loop (+ i 1) (+ o sps:bytes-per-word)))
            (sps:if n-bytes
              (sps->c::pack-string-tail str pp n-bytes)
              (sps:io:print:string pp ",0"))))))) ; NUL terminate


(define (sps->c::do-expr-str str-node str state)
  (let ((mp (sps->c::state:main-port state))
        (pp (sps->c::state:preamble-port state))
        (slc (sps->c::state:string-literal-count state))
        (sl (sps:strings:string:length str)))
    (sps:and
      (sps:io:print:string pp "static const sps_val sps_sl")
      (sps:io:print:int pp slc)
      (sps:io:print:string pp "[] = {")
      (sps->c::pack-string str pp)
      (sps:io:print:string pp "};")
      (sps:io:newline pp)
      (sps:io:print:string pp "#define sps_sl")
      (sps:io:print:int pp (+ slc 1))
      (sps:io:print:string pp " ((sps_val)&sps_sl")
      (sps:io:print:int pp slc)
      (sps:io:print:string pp "[1])")
      (sps:io:newline pp)
      (sps:io:print:string mp "sps_sl")
      (sps:io:print:int mp (+ slc 1))
      (begin (sps->c::state:string-literal-count! state (+ 2 slc)) #t))))


(define (sps->c::do-expr-bool bool-node bool state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:io:print:bool mp bool)))


(define (sps->c::error-if-spurious-if-node if-node end-node state)
  (let ((next-node (sps:ast:next end-node)))
    (sps:if next-node
        (begin
          (sps->c::error:start next-node "expected_expr_at_if_end")
          (sps->c::error:node-arg if-node)
          (sps->c::error:end))
        #t)))

(define-forward (sps->c::do-expr node state))
(define-forward (sps->c::do-exprs node state))

(define (sps->c::do-expr-if-false if-node false-node state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:if false-node
        (sps:and
          (sps->c::error-if-spurious-if-node if-node false-node state)
          (sps->c::do-expr false-node state)
          #t)
        (sps:io:print:string mp " sps_unspecified()"))))

(define (sps->c::do-expr-if-true if-node true-node state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:if true-node
        (sps:and
          (sps->c::do-expr true-node state)
          (sps:io:print:string mp " : ")
          (sps->c::do-expr-if-false if-node (sps:ast:next true-node) state))
        (begin
          (sps->c::error:start if-node "if_missing_true_expr")
          (sps->c::error:end)))))


; R4RS 4.1.5
;
; (if <test> <consequent> <alternate>)
; (if <test> <consequent>)
;
(define (sps->c::do-expr-if if-node state)
  (let ((cond-node (sps:ast:next if-node))
        (mp (sps->c::state:main-port state)))
    (sps:if cond-node
        (sps:and
          (sps->c::do-expr cond-node state)
          (sps:io:newline mp)
          (sps:io:print:string mp " ? ")
          (sps->c::do-expr-if-true if-node (sps:ast:next cond-node) state))
        (begin
          (sps->c::error:start if-node "malformed_if")
          (sps->c::error:end)))))


(define (sps->c::do-expr-and-exprs expr state mp)
  (sps:if expr
      (sps:and
        (sps:io:print:string mp "({ sps_val sps_g_and_r = (sps_val) ")
        (sps->c::do-expr expr state)
        (sps:io:print:string mp ";")
        (sps:io:newline mp)
        (sps:io:print:string mp "  sps_g_and_r")
        (sps:io:newline mp)
        (sps:io:print:string mp "    ? ")
        (sps->c::do-expr-and-exprs (sps:ast:next expr) state mp)
        (sps:io:newline mp)
        (sps:io:print:string mp "    : 0;")
        (sps:io:newline mp)
        (sps:io:print:string mp "})"))
      (sps:io:print:string mp " sps_g_and_r")))


; R4RS 4.2.1
;
; (and <test1> ...)
;
(define (sps->c::do-expr-and and-node state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:and
      (sps:io:print:string mp "({ sps_val sps_g_and_r = 1;")
      (sps:io:newline mp)
      (sps:io:print:string mp "   sps_g_and_r ")
      (sps:io:newline mp)
      (sps:io:print:string mp "     ? ")
      (sps->c::do-expr-and-exprs (sps:ast:next and-node) state mp)
      (sps:io:newline mp)
      (sps:io:print:string mp "     : 0; ")
      (sps:io:newline mp)
      (sps:io:print:string mp "})"))))


; R4RS 4.2.3
;
; (begin <expresion1> <expression2> ...)
;
(define (sps->c::do-expr-begin begin-node state) 
  (let ((mp (sps->c::state:main-port state)))
    (sps:and
      (sps:io:print:string mp "({ ")
      (let loop ((expr (sps:ast:next begin-node)))
        (sps:if expr
            (sps:and
              (sps->c::do-expr expr state)
              (sps:io:print:string mp ";")
              (sps:io:newline mp)
              (loop (sps:ast:next expr)))
            (sps:io:print:string mp "})"))))))


;
; XXX: should really check that case only occurs once and that it
; is the last arm.
;
(define (sps->c::do-expr-case-default case-node state case-arm-node)
  (let ((mp (sps->c::state:main-port state)))
    (sps:and
      (sps:io:print:string mp "default: sps_g_c = ")
      (sps->c::do-exprs (sps:ast:next case-arm-node) state)
      (sps:io:print:string mp "; break;")
      (sps:io:newline mp))))


;
; XXX: should really check that the choices are static values
;
(define (sps->c::do-expr-case-arm-choices case-arm-node state)
  (let ((mp (sps->c::state:main-port state)))
    (let loop ((choice (sps:ast:value case-arm-node)))
      (sps:if choice
          (sps:and
            (sps:io:print:string mp "case ")
            (sps->c::do-expr choice state)
            (sps:io:print:string mp ": ")
            (loop (sps:ast:next choice)))
          #t))))


(define (sps->c::do-expr-case-list case-node state case-arm-node)
  (let ((mp (sps->c::state:main-port state)))
    (sps:and
      (sps->c::do-expr-case-arm-choices case-arm-node state)
      (sps:io:print:string mp "sps_g_c = ")
      (sps->c::do-exprs (sps:ast:next case-arm-node) state)
      (sps:io:print:string mp "; break;")
      (sps:io:newline mp))))


(define (sps->c::do-expr-case-arm case-node state arm-head-node)
  (cond ((sps->c::list? arm-head-node)
         (sps->c::do-expr-case-list case-node state arm-head-node))
        ((sps->c::specific-syntax? arm-head-node sps->c::literal:else)
         (sps->c::do-expr-case-default case-node state arm-head-node))
        (else
         (sps->c::error:start arm-head-node "malformed_case")
         (sps->c::error:end))))


(define (sps->c::do-expr-case-arms case-node state case-arms)
  (let ((mp (sps->c::state:main-port state)))
    (let loop ((arm-node case-arms))
      (sps:if arm-node
          (let ((arm-head-node (sps:ast:value arm-node)))
            (sps:if arm-head-node
                (sps:and
                  (sps->c::do-expr-case-arm case-node state arm-head-node)
                  (loop (sps:ast:next arm-node)))
                (begin
                  (sps->c::error:start arm-head-node "malformed_case")
                  (sps->c::error:end))))
          #t))))

(define (sps->c::do-expr-case case-node state)
  (let ((mp (sps->c::state:main-port state))
        (test-node (sps:ast:next case-node)))
    (sps:if test-node
        (sps:and
          (sps:io:print:string mp "({ sps_val sps_g_c; switch (")
          (sps->c::do-expr test-node state)
          (sps:io:print:string mp ") {")
          (sps:io:newline mp)
          (sps->c::do-expr-case-arms case-node state (sps:ast:next test-node))
          (sps:io:print:string mp "}; sps_g_c; })")
          (sps:io:newline mp))
        (begin
          (sps->c::error:start case-node "case_missing_test")
          (sps->c::error:end)))))

    

(define (sps->c::do-expr-else else-node state)
  (sps->c::error:start else-node "else_outside_cond_or_case")
  (sps->c::error:end))

(define (sps->c::do-cond-arm cond-arm state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:if cond-arm
        (sps:and
          (if (not (sps->c::specific-syntax? cond-arm sps->c::literal:else))
              (sps->c::do-expr cond-arm state)
              (sps:io:print:string mp " 1 "))
          (sps:io:newline mp)
          (sps:io:print:string mp " ? ")
          (sps->c::do-exprs (sps:ast:next cond-arm) state)
          (sps:io:newline mp)
          (sps:io:print:string mp " : "))
        (begin
          (sps->c::error:start cond-arm "cond_arm_missing_test")
          (sps->c::error:end)))))
    

; R4RS 4.2.1
;
; (cond <clause1> <clause2> ...)
;
; where <clause> should have the form (<test> <expression> ...)
; where <test> is any expression.  The last <clause> may be an ``else clause''
; which has the form (else <expression1> <expression2> ...)
;
(define (sps->c::do-expr-cond cond-node state)
  (let ((mp (sps->c::state:main-port state)))
    (let loop ((test-list (sps:ast:next cond-node)))
      (sps:if test-list
          (sps:and
            (sps->c::error-if-not-list test-list state)
            (let ((cond-arm (sps:ast:value test-list)))
              (sps->c::do-cond-arm cond-arm state)
              (loop (sps:ast:next test-list))))
          (sps:and
            (sps:io:print:string mp " sps_unspecified() ")
            (sps:io:newline mp))))))



(define (sps->c::error-if-junk-at-binding-end binding-value)
  (let ((next-node (sps:ast:next binding-value)))
    (sps:if next-node
        (begin
          (sps->c::error:start next-node "junk_after_binding_value")
          (sps->c::error:node-arg binding-value)
          (sps->c::error:end))
        #t)))

(define (sps->c::do-let*-binding binding-node state)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state)))
    (sps:and
      (sps->c::error-if-not-id binding-node state)
      (let ((value-node (sps:ast:next binding-node))
            (id (sps:ast:value binding-node)))
        (sps:if value-node
            (sps:and
              (sps:io:print:string mp "({ sps_val sps_g_lb = ")
              (sps->c::do-expr value-node state)
              (sps->c::error-if-junk-at-binding-end value-node)
              (let ((st-node (sps:symbol-table:enter st id binding-node)))
                (sps:and
                  st-node
                  (sps:assert (sps:symbol-table:node:new? st-node))
                  ; binding-node is just used an any non-zero value.
                  (begin (sps:symbol-table:node:value! st-node binding-node) #t)
                  (sps:io:print:string mp ";")
                  (sps:io:newline mp)
                  (sps:io:print:string mp "sps_val ")
                  (let ((gid (sps:symbol-table:node:unique-id st-node)))
                    (sps->c::output-generated-id gid mp))))
              (sps:io:print:string mp " = sps_g_lb;")
              (sps:io:newline mp))
            (begin
              (sps->c::error:start binding-node "missing_value_in_let*_binding")
              (sps->c::error:end)))))))


(define (sps->c::close-let*-scopes n-bindings state)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state)))
    (let loop ((i 0))
      (or (= i n-bindings)
          (sps:and
            (begin (sps:symbol-table:close-scope st) #t)
            (sps:io:print:string mp ";")
            (sps:io:newline mp)
            (sps:io:print:string mp "})")
            (sps:io:newline mp)
            (loop (+ i 1)))))))


(define (sps->c::do-let*-body let*-node let*-body state n-bindings)
  (sps:if let*-body
      (sps:and
       (sps->c::do-exprs let*-body state)
       (sps->c::close-let*-scopes n-bindings state))
      (begin
        (sps->c::error:start let*-node "missing_let*_body")
        (sps->c::error:end))))


;
; R4RS 4.2.2
;
; (let* <bindings> <body>)
;
; where <bindings> have the form ((<variable1> <init1>) ...)
;
(define (sps->c::do-expr-let* let*-node state)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state))
        (bindings (sps:ast:next let*-node)))
    (sps:if bindings
        (sps:if (sps->c::list? bindings)
            (let loop ((binding (sps:ast:value bindings)) (n-bindings 0))
              (sps:if binding
                  (sps:and
                    (sps:symbol-table:open-scope st)
                    (sps->c::error-if-not-list binding state)
                    (sps->c::do-let*-binding (sps:ast:value binding) state)
                    (loop (sps:ast:next binding) (+ 1 n-bindings)))
                  (let ((let*-body (sps:ast:next bindings)))
                    (sps->c::do-let*-body let*-node let*-body state n-bindings))))
            (begin
              (sps->c::error:start let*-node "malformed_let*_bindings")
              (sps->c::error:node-arg bindings)
              (sps->c::error:end)))
        (begin
          (sps->c::error:start let*-node "missing_bindings_in_let*")
          (sps->c::error:end)))))



(define (sps->c::do-let-body let-node let-body state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:if let-body
        (sps:and
          (sps->c::do-exprs let-body state)
          (sps:io:print:string mp ";")
          (sps:io:print:string mp "})")
          (sps:io:newline mp))
        (begin
          (sps->c::error:start let-node "missing_let_body")
          (sps->c::error:end)))))


(define (sps->c::do-let-bindings-again bindings state)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state))
        (binding-depth (sps->c::state:binding-depth state)))
    (let loop ((binding-node (sps:ast:value bindings)) (i binding-depth))
      (sps:if binding-node
          (let* ((id-node (sps:ast:value binding-node))
                 (id (sps:ast:value id-node))
                 (st-node (sps:symbol-table:enter st id binding-node)))
            (sps:and
              st-node
              (sps:assert (sps:symbol-table:node:new? st-node))
              (sps:io:print:string mp "sps_val ")
              (let ((gid (sps:symbol-table:node:unique-id st-node)))
                (sps->c::output-generated-id gid mp))
              (sps:io:print:string mp " = sps_g_l")
              (sps:io:print:int mp i)
              (sps:io:print:string mp ";")
              (sps:io:newline mp)
              ; id-node is just used as any non-zero value.
              (begin (sps:symbol-table:node:value! st-node id-node) #t)
              (loop (sps:ast:next binding-node) (+ i 1))))
          #t))))


(define (sps->c::do-let-binding binding-node state binding-id)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state)))
    (sps:and
      (sps->c::error-if-not-id binding-node state)
      (let ((value-node (sps:ast:next binding-node)))
        (sps:if value-node
            (sps:and
              (sps:io:print:string mp "sps_val sps_g_l")
              (sps:io:print:int mp binding-id)
              (sps:io:print:string mp " = ")
              (sps->c::do-expr value-node state)
              (sps:io:print:string mp ";")
              (sps:io:newline mp)
              (sps->c::error-if-junk-at-binding-end value-node))
            (begin
              (sps->c::error:start binding-node "missing_value_in_let_binding")
              (sps->c::error:end)))))))


; R4RS 4.2.2
;
; (let <bindings> <body>)
;
; where <bindings> has the form ((<variable1 <init1>) ...)
;
(define (sps->c::do-expr-let-unnamed let-node state bindings)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state))
        (binding-depth (sps->c::state:binding-depth state)))
    (let loop ((binding (sps:ast:value bindings)) (n-bindings 0))
      (sps:if binding
          (sps:and
            (sps->c::error-if-not-list binding state)
            (sps->c::do-let-binding (sps:ast:value binding)
                                    state (+ binding-depth n-bindings))
            (loop (sps:ast:next binding) (+ 1 n-bindings)))
          (sps:and
            (sps:symbol-table:open-scope st)
            (sps->c::do-let-bindings-again bindings state)
            (let ((let-body (sps:ast:next bindings))
                  (new-depth (+ binding-depth n-bindings)))
              (sps:and
                (begin (sps->c::state:binding-depth! state new-depth) #t)
                (sps->c::do-let-body let-node let-body state)
                (begin 
                  (sps->c::state:binding-depth! state binding-depth)
                  (sps:symbol-table:close-scope st) #t))))))))


(define (sps->c::make-let-proc-node state binding-depth n-args)
  (let* ((pool (sps->c::state:stack-pool state))
         (size sps->c::let-proc:size)
         (alignment sps:bytes-per-word)
         (node (sps:mem:sp:alloc pool size alignment)))
    (sps:and
      node
      (begin
        (sps->c::let-proc:tag! node sps->c::let-proc:tag-value)
        (sps->c::let-proc:binding-depth! node binding-depth)
        (sps->c::let-proc:n-args! node n-args)
        #t)
    node)))

(define (sps->c::do-expr-let-named-name-label st-node state)
  (let ((mp (sps->c::state:main-port state))
        (gid (sps:symbol-table:node:unique-id st-node)))
      (sps:and
        (sps->c::output-generated-id gid mp)
        (sps:io:print:string mp ":")
        (sps:io:newline mp))))


(define (sps->c::report-duplicate-definition def-node id-node st-node)
  (let ((old-definition (sps:symbol-table:node:source st-node)))
    (sps->c::error:start def-node "duplicate_definition")
    (sps->c::error:node-arg id-node)
    (sps->c::error:node-arg old-definition)
    (sps->c::error:end)))

(define (sps->c::error-if-already-defined def-node id-node st-node)
  (or (sps:symbol-table:node:new? st-node)
      (sps->c::report-duplicate-definition def-node id-node st-node)))


(define (sps->c::do-expr-let-named-name let-node state name-node binding-depth n-args)
  (let* ((st (sps->c::state:symbol-table state))
         (id (sps:ast:value name-node))
         (st-node (sps:symbol-table:enter st id name-node)))
    (sps:and
      st-node
      (or (sps:symbol-table:node:new? st-node)
          (sps->c::report-duplicate-definition let-node name-node st-node))
      (let ((let-proc (sps->c::make-let-proc-node state binding-depth n-args)))
        (sps:and
          let-proc
          (begin (sps:symbol-table:node:value! st-node let-proc) #t)))
      (sps->c::do-expr-let-named-name-label st-node state))))


; R4RS 4.2.4
;
; (let <variable> <bindings> <body>)
;
(define (sps->c::do-expr-let-named let-node state name-node)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state))
        (bindings (sps:ast:next name-node))
        (binding-depth (sps->c::state:binding-depth state)))
    (sps:and
      (sps->c::error-if-not-list bindings state)
      (let loop ((binding (sps:ast:value bindings)) (n-bindings 0))
        (sps:if binding
            (sps:and
              (sps->c::error-if-not-list binding state)
              (sps->c::do-let-binding (sps:ast:value binding) state
                                      (+ binding-depth n-bindings))
              (loop (sps:ast:next binding) (+ 1 n-bindings)))
            (sps:and
              (sps:symbol-table:open-scope st)
              (sps->c::do-expr-let-named-name let-node state name-node
                                              binding-depth n-bindings)
              (sps:symbol-table:open-scope st)
              (sps:io:print:string mp "({ ")
              (sps->c::do-let-bindings-again bindings state)
              (let ((let-body (sps:ast:next bindings))
                    (new-depth (+ binding-depth n-bindings)))
                (sps:and
                  (begin (sps->c::state:binding-depth! state new-depth) #t)
                  (sps->c::do-let-body let-node let-body state)
                  (begin 
                    (sps:symbol-table:close-scope st)
                    (sps:symbol-table:close-scope st)
                    (sps->c::state:binding-depth! state binding-depth)
                    (sps:io:print:string mp ";})"))))))))))


(define (sps->c::do-expr-let let-node state) 
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state))
        (next-node (sps:ast:next let-node)))
    (cond ((sps->c::list? next-node)
           (sps:and
             (sps:io:print:string mp "({ ")
             (sps->c::do-expr-let-unnamed let-node state next-node)))
          ((sps->c::id? next-node)
           (sps:and
             (sps:io:print:string mp "({ ")
             (sps->c::do-expr-let-named let-node state next-node)))
          (else
           (sps:if next-node
               (begin
                 (sps->c::error:start let-node "malformed_let_bindings")
                 (sps->c::error:node-arg next-node))
               (sps->c::error:start let-node "missing_bindings_in_let"))
           (sps->c::error:end)))))


(define (sps->c::do-expr-or-exprs expr state mp)
  (sps:if expr
      (sps:and
        (sps:io:print:string mp "({ sps_val sps_g_or_r = (sps_val) ")
        (sps->c::do-expr expr state)
        (sps:io:print:string mp ";")
        (sps:io:newline mp)
        (sps:io:print:string mp "  sps_g_or_r")
        (sps:io:newline mp)
        (sps:io:print:string mp "    ? sps_g_or_r")
        (sps:io:newline mp)
        (sps:io:print:string mp "    : ")
        (sps->c::do-expr-or-exprs (sps:ast:next expr) state mp)
        (sps:io:print:string mp ";")
        (sps:io:newline mp)
        (sps:io:print:string mp "})"))
      (sps:io:print:string mp " 0")))

; R4RS 4.2.1
;
; (or <test1> ...)
;
(define (sps->c::do-expr-or or-node state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:and
      (sps:io:print:string mp "({ sps_val sps_g_or_r = 0;")
      (sps:io:newline mp)
      (sps:io:print:string mp "   sps_g_or_r ")
      (sps:io:newline mp)
      (sps:io:print:string mp "     ? sps_g_or_r ")
      (sps:io:newline mp)
      (sps:io:print:string mp "     : ")
      (sps->c::do-expr-or-exprs (sps:ast:next or-node) state mp)
      (sps:io:print:string mp "; })"))))



(define (sps->c::do-proc-args-check app-node n-actuals n-formals)
  (cond ((< n-actuals n-formals)
         (sps->c::error:start app-node "too_few_args")
         (sps->c::error:int-arg n-actuals)
         (sps->c::error:int-arg n-formals)
         (sps->c::error:end))
        ((> n-actuals n-formals)
         (sps->c::error:start app-node "too_many_args")
         (sps->c::error:int-arg n-actuals)
         (sps->c::error:int-arg n-formals)
         (sps->c::error:end))
        (else #t)))


(define (sps->c::do-call-args app-node state n-formal-args)
  (let ((mp (sps->c::state:main-port state)))
    (let loop ((arg (sps:ast:next app-node)) (sep "") (n-actual-args 0))
      (sps:if arg
          (sps:and
            (sps:io:print:string mp sep)
            (sps->c::do-expr arg state)
            (loop (sps:ast:next arg) ", " (+ n-actual-args 1)))
          (sps:and
            (sps:io:print:string mp ")")
            (or (< n-formal-args 0)
                (sps->c::do-proc-args-check app-node n-actual-args n-formal-args)))))))


(define (sps->c::output-prim-args proc state)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state)))
    (let loop ((arg (sps->c::proc:args proc)) (sep ""))
      (sps:if arg
          (let* ((id (sps:ast:value arg))
                 (st-node (sps:symbol-table:lookup st id)))
            (sps:assert st-node)
            (let ((gid (sps:symbol-table:node:unique-id st-node)))
              (sps:and
                (sps:io:print:string mp sep)
                (sps->c::output-generated-id gid mp)
                (loop (sps:ast:next arg) ", "))))
          (sps:io:print:string mp ")")))))


(define (sps->c::error-if-junk-at-prim-end prim-name-node)
  (let ((next-node (sps:ast:next prim-name-node)))
    (sps:if next-node
        (begin
          (sps->c::error:start next-node "junk_after_prim_end")
          (sps->c::error:node-arg prim-name-node)
          (sps->c::error:end))
        #t)))


(define (sps->c::do-expr-fun-app app-node state st-node proc)
  (let ((mp (sps->c::state:main-port state))
        (id (sps:symbol-table:node:unique-id st-node))
        (n-actuals (sps->c::proc:n-args proc)))
    (sps:and
      (sps->c::output-generated-id id mp)
      (sps:io:print:string mp "(")
      (sps->c::do-call-args app-node state n-actuals))))


;
; Deals with expressions of the form (f arg1 arg2 ...) where f is bound but it
; is not to a known function i.e. f is either a parameter, let-bound
; or perhaps a top-level value.  It is assumed that at runtime f will be
; bound to a function so the necessary cast is used to turn it into 
; a function and it is applied to its arguments.
;
(define (sps->c::do-expr-indirect-fun-app app-node state st-node)
  (let ((mp (sps->c::state:main-port state))
        (id (sps:symbol-table:node:unique-id st-node)))
    (sps:and
      (sps:io:print:string mp "((sps_val (*)())")
      (sps->c::output-generated-id id mp)
      (sps:io:print:string mp ")(")
      (sps->c::do-call-args app-node state -1))))


(define (sps->c::do-let-proc-args app-node state let-proc)
  (let ((mp (sps->c::state:main-port state))
        (args (sps:ast:next app-node))
        (binding-depth (sps->c::let-proc:binding-depth let-proc))
        (n-formals (sps->c::let-proc:n-args let-proc)))
    (let loop ((arg args) (n-actuals 0) (local-id binding-depth))
      (sps:if arg
          (sps:and
            (sps:io:print:string mp "sps_g_l")
            (sps:io:print:int mp local-id)
            (sps:io:print:string mp " = ")
            (sps->c::do-expr arg state)
            (sps:io:print:string mp "; ")
            (loop (sps:ast:next arg) (+ 1 n-actuals) (+ 1 local-id)))
          (sps->c::do-proc-args-check app-node n-actuals n-formals)))))


(define (sps->c::do-expr-app-let-proc app-node state st-node)
  (let ((mp (sps->c::state:main-port state))
        (let-proc (sps:symbol-table:node:value st-node))
        (id (sps:symbol-table:node:unique-id st-node)))
    (sps:and
      (sps:io:print:string mp "({ ")
      (sps->c::do-let-proc-args app-node state let-proc)
      (sps:io:print:string mp "goto ")
      (sps->c::output-generated-id id mp)
      (sps:io:print:string mp "; 0;})"))))


(define (sps->c::do-expr-app id-node state)
  (let ((mp (sps->c::state:main-port state))
        (st (sps->c::state:symbol-table state))
        (hash-id (sps:ast:value id-node)))
    (let ((st-node (sps:symbol-table:lookup st hash-id)))
      (sps:if st-node
          (let ((v (sps:symbol-table:node:value st-node)))
            (cond ((sps->c::proc? v)
                   (sps->c::do-expr-fun-app id-node state st-node v))
                  ((sps->c::syntax? v)
                   ((sps->c::syntax:transformer v) id-node state))
                  ((sps->c::let-proc? v)
                   (sps->c::do-expr-app-let-proc id-node state st-node))
                  (else
                   (sps->c::do-expr-indirect-fun-app id-node state st-node))))
          (begin
            (sps->c::error:start id-node "undefined_id")
            (sps->c::error:node-arg id-node)
            (sps->c::error:end))))))
            

(define (sps->c::do-expr-list list functor state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:if functor
        (cond ((sps->c::id? functor) 
               (sps->c::do-expr-app functor state))
              ((sps->c::list? functor) 
               (sps:and
                 (sps:io:print:string mp "((sps_val (*)())(")
                 (sps->c::do-expr-list functor (sps:ast:value functor) state)
                 (sps:io:print:string mp "))(")
                 (sps->c::do-call-args functor state -1)))
              (else
               (sps->c::error:start functor "malformed_application")
               (sps->c::error:node-arg functor)
               (sps->c::error:end)))
        (begin
          (sps->c::error:start list "empty_expr")
          (sps->c::error:end)))))


(define (sps->c::do-expr expr state)
  (sps:ast::fold sps->c::do-expr-int sps->c::do-expr-id sps->c::do-expr-str
                 sps->c::do-expr-char sps->c::do-expr-bool sps->c::do-expr-list
                 state expr))


(define (sps->c::do-exprs exprs state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:and
      (sps:io:print:string mp "({ 1; ")
      (let loop ((expr exprs))
        (sps:if expr
            (sps:and
              (sps->c::do-expr expr state)
              (sps:io:print:string mp ";")
              (sps:io:newline mp)
              (loop (sps:ast:next expr)))
            (sps:and
              (sps:io:print:string mp "})")
              (sps:io:newline mp)))))))


(define (sps->c::do-define-exprs state exprs)
  (let ((st (sps->c::state:symbol-table state))
        (mp (sps->c::state:main-port state)))
    (sps:and
      (sps:symbol-table:open-scope st)
      (let loop ((expr exprs))
        (sps:if expr
            (let ((next-expr (sps:ast:next expr)))
              (sps:and
                (sps:io:print:string mp (sps:if next-expr "(void)" "return "))
                (sps->c::do-expr expr state)
                (sps:io:print:string mp ";")
                (sps:io:newline mp)
                (loop next-expr)))
            (begin (sps:symbol-table:close-scope st) #t))))))


(define (sps->c::report-duplicate-param param st-node)
  (let ((old-param (sps:symbol-table:node:source st-node)))
    (sps->c::error:start param "duplicate_parameter")
    (sps->c::error:id-arg (sps:ast:value param))
    (sps->c::error:node-arg old-param)
    (sps->c::error:end)))


(define (sps->c::make-proc-node state args n-args forward?)
  (let* ((pool (sps->c::state:stack-pool state))
         (size sps->c::proc:size)
         (alignment sps:bytes-per-word)
         (node (sps:mem:sp:alloc pool size alignment)))
    (sps:and
      node
      (begin
        (sps->c::proc:tag! node sps->c::proc:tag-value)
        (sps->c::proc:args! node args)
        (sps->c::proc:n-args! node n-args)
        (sps->c::proc:forward! node forward?)
        #t)
    node)))


(define (sps->c::make-syntax-node state transformer)
  (let* ((pool (sps->c::state:stack-pool state))
         (size sps->c::syntax:size)
         (alignment sps:bytes-per-word)
         (node (sps:mem:sp:alloc pool size alignment)))
    (sps:and
      node
      (begin
        (sps->c::syntax:tag! node sps->c::syntax:tag-value)
        (sps->c::syntax:transformer! node transformer)
        #t)
    node)))


(define (sps->c::do-define-fun-args first-arg state forward? extra-sep)
  (let ((st (sps->c::state:symbol-table state))
        (mp (sps->c::state:main-port state)))
    (let loop ((arg first-arg) (n-args 0) (sep ""))
      (sps:if arg
          (sps:and
            (sps->c::error-if-not-id arg state)
            (let* ((id (sps:ast:value arg))
                   (st-node (sps:symbol-table:enter st id arg)))
              (sps:and
               st-node
               (if (sps:symbol-table:node:new? st-node)
                   (let ((gid (sps:symbol-table:node:unique-id st-node)))
                     (sps:and
                       (sps:io:print:string mp sep)
                       (sps:io:print:string mp extra-sep)
                       (sps->c::output-generated-id gid mp)
                       ; arg is just used as an arbitrary non-zero value.
                       (begin (sps:symbol-table:node:value! st-node arg) #t)
                       (loop (sps:ast:next arg) (+ n-args 1) ", ")))
                   (sps->c::report-duplicate-param arg st-node)))))
          (sps:and
            (sps:io:print:string mp ")")
            (sps->c::make-proc-node state first-arg n-args forward?))))))


(define (sps->c::output-fun-name st-node state)
  (let ((mp (sps->c::state:main-port state))
        (hash-id (sps:symbol-table:node:id st-node))
        (gid (sps:symbol-table:node:unique-id st-node)))
    (sps:and
      (sps:io:print:string mp "/* ")
      (sps->c::display-id hash-id mp)
      (sps:io:print:string mp " */")
      (sps:io:newline mp)
      (sps:io:print:string mp "static sps_val ")
      (sps->c::output-generated-id gid mp)
      (sps:io:print:string mp "("))))


(define (sps->c::output-fun-trailer state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:and (sps:io:print:string mp "}") (sps:io:newline mp))))


; 
; XXX: should check that the arguments in the forward declaration
; and current declaration are equivalent.
;
(define (sps->c::compatible-forward-fun-decl? st-node)
  (let ((v (sps:symbol-table:node:value st-node)))
    (sps:and
     (sps->c::proc? v)
     (sps->c::proc:forward? v)
     (begin (sps->c::proc:forward! v #f) #t))))


(define (sps->c::define-fun define-node state list-node)
  (let* ((st (sps->c::state:symbol-table state))
         (mp (sps->c::state:main-port state))
         (id-node (sps:ast:value list-node)))
    (sps:and
      (sps->c::error-if-not-id id-node state)
      (let* ((id (sps:ast:value id-node))
             (st-node (sps:symbol-table:enter st id id-node)))
        (sps:and
          st-node
          (sps:or
            (sps:symbol-table:node:new? st-node)
            (sps->c::compatible-forward-fun-decl? st-node)
            (sps->c::report-duplicate-definition define-node id-node st-node))
          (sps:symbol-table:open-scope st)
          (sps->c::output-fun-name st-node state)
          (let* ((args (sps:ast:next id-node))
                 (proc (sps->c::do-define-fun-args args state #f "sps_val ")))
            (sps:and
              proc
              (begin (sps:symbol-table:node:value! st-node proc) #t)))
          (sps:io:newline mp)
          (sps:io:print:string mp "{")
          (sps:io:newline mp)
          (let ((body-exprs (sps:ast:next list-node)))
            (sps:and
              (sps:io:print:string mp "if (sps_trace) {")
              (sps:io:print:string mp "fwrite(\"")
              (let* ((real-id (sps:symbol-table:node:id st-node))
                     (len (sps:strings:string:length real-id)))
                (sps:and
                  (sps:io:print:string mp real-id)
                  (sps:io:print:string mp "\\n\", 1, ");
                  (sps:io:print:int mp (+ len 1))))
              (sps:io:print:string mp ", stdout);}")
              (sps:io:newline mp)
              (sps->c::do-define-exprs state body-exprs)))))
      (sps->c::output-fun-trailer state)
      (begin (sps:symbol-table:close-scope st) #t))))


;
; The reason for using #define rather than "static const sps_val"
; is that for input like :-
; 
;    (define wobbly (* 10 12))
;
; The compiler will genereate something like :-
;
;    static sps_val g20030(sps_val g20032, sps_val g20033)
;    {
;            return sps_mul(g20032, g20033);
;    }
;
;   static const sps_val g23 = (sps_val)g20030(10, 12);
;
; but this wll cause GCC to complain that the initializer isn't static even
; though it it going to inline g20030 and sps_mul.
;
(define (sps->c::do-expr-define-val-prolog state st-node)
  (let ((mp (sps->c::state:main-port state))
        (real-id (sps:symbol-table:node:id st-node))
        (generated-id (sps:symbol-table:node:unique-id st-node)))
    (sps:and
      (sps:io:print:string mp "/* ")
      (sps->c::display-id real-id mp)
      (sps:io:print:string mp " */")
      (sps:io:newline mp)
      (sps:io:print:string mp "#define ")
      (sps->c::output-generated-id generated-id mp)
      (sps:io:print:string mp " "))))

;      (sps:io:print:string mp " ((sps_val)("))))


(define (sps->c::do-expr-define-val-epilog state)
  (let ((mp (sps->c::state:main-port state)))
    (sps:and 
      ;(sps:io:print:string mp "))")
      (sps:io:newline mp))))


(define (sps->c::do-expr-define-val define-node state id-node)
  (let* ((st (sps->c::state:symbol-table state))
         (mp (sps->c::state:main-port state))
         (id (sps:ast:value id-node))
         (st-node (sps:symbol-table:enter st id id-node)))
    (sps:and
      st-node
      (or (sps:symbol-table:node:new? st-node)
          (sps->c::report-duplicate-definition define-node id-node st-node))
      (sps->c::do-expr-define-val-prolog state st-node)
      (let ((body (sps:ast:next id-node)))
        (sps:if body
            (let ((body-val (sps->c::do-expr body state)))
              (sps:symbol-table:node:value! st-node body-val)
              body-val)
            (begin
              (sps->c::error:start define-node "missing_value_in_define")
              (sps->c::error:end))))
      (sps->c::do-expr-define-val-epilog state))))


(define (sps->c::do-expr-define define-node state)
  (let ((name (sps:ast:next define-node)))
    (sps:if name
        (cond ((sps->c::list? name)
               (sps->c::define-fun define-node state name))
              ((sps->c::id? name)
               (sps->c::do-expr-define-val define-node state name))
              (else
               (sps->c::error:start name "malformed_define_name")
               (sps->c::error:node-arg name)
               (sps->c::error:end)))
        (begin
          (sps->c::error:start define-node "missing_define_name")
          (sps->c::error:end)))))


(define (sps->c::do-expr-define-external-body prim-node body-nodes state proc)
  (let ((mp (sps->c::state:main-port state))
        (prim-name-node body-nodes))
    (sps:if prim-name-node
        (if (= sps:ast::kind-str (sps:ast::kind prim-name-node))
            (sps:and 
              (sps:io:print:string mp " ")
              (sps->c::display-str (sps:ast:value prim-name-node) mp)
              (sps:io:print:string mp "(")
              (sps->c::output-prim-args proc state)
              (sps:io:newline mp)
              (sps->c::error-if-junk-at-prim-end prim-name-node))
            (begin
              (sps->c::error:start prim-name-node "illegal_prim_name")
              (sps->c::error:node-arg prim-node)
              (sps->c::error:end)))
        (begin
          (sps->c::error:start prim-node "missing_prim_name")
          (sps->c::error:node-arg prim-node)
          (sps->c::error:end)))))


(define (sps->c::output-external-fun-name st-node state)
  (let ((mp (sps->c::state:main-port state))
        (real-id (sps:symbol-table:node:id st-node))
        (generated-id (sps:symbol-table:node:unique-id st-node)))
    (sps:and
      (sps:io:print:string mp "/* ")
      (sps:io:print:string mp real-id)
      (sps:io:print:string mp " */")
      (sps:io:newline mp)
      (sps:io:print:string mp "#define ")
      (sps->c::output-generated-id generated-id mp)
      (sps:io:print:string mp "("))))
    



(define (sps->c::do-expr-define-external-fun define-node state list-node)
  (let ((st (sps->c::state:symbol-table state))
        (mp (sps->c::state:main-port state))
        (id-node (sps:ast:value list-node)))
    (sps:and
      (sps->c::error-if-not-id id-node state)
      (let* ((id (sps:ast:value id-node))
             (st-node (sps:symbol-table:enter st id id-node)))
        (sps:and
          st-node
          (or
            (sps:symbol-table:node:new? st-node)
            (sps->c::report-duplicate-definition define-node id-node st-node))
          (sps:symbol-table:open-scope st)
          (sps->c::output-external-fun-name st-node state)
          (let* ((args (sps:ast:next id-node))
                 (proc (sps->c::do-define-fun-args args state #f "")))
            (sps:and
              proc
              (begin (sps:symbol-table:node:value! st-node proc) #t)
              (let ((body-nodes (sps:ast:next list-node)))
                (sps->c::do-expr-define-external-body id-node body-nodes state proc))))))
      (sps:io:newline mp)
      (begin (sps:symbol-table:close-scope st) #t))))


;
; (define-external (<variable> <formals>) <external-name>)
;
; where 
;
;  <formals> ::= <id> ...
;  <external-name> :: <string>
;
(define (sps->c::do-expr-define-external define-node state)
  (let ((name-node (sps:ast:next define-node)))
    (if (sps->c::list? name-node)
        (sps->c::do-expr-define-external-fun define-node state name-node)
        (begin
          (sps->c::error:start name-node "malformed_define_external")
          (sps->c::error:node-arg define-node)
          (sps->c::error:end)))))


(define (sps->c::error-if-junk-at-forward-end forward-args)
  (let ((next-node (sps:ast:next forward-args)))
    (sps:if next-node
        (begin
          (sps->c::error:start next-node "junk_after_define_forward_args")
          (sps->c::error:node-arg forward-args)
          (sps->c::error:end))
        #t)))


;
; At present the only real use for a val node is to signal that
; the declaration is a forward declaration so one single instance
; is cached.
;
(define (sps->c::make-val-node state forward?)
  (let ((vn (sps->c::state:forward-val-decl state)))
    (sps:or
      vn
      (let* ((pool (sps->c::state:stack-pool state))
             (size sps->c::val:size)
             (alignment sps:bytes-per-word)
             (node (sps:mem:sp:alloc pool size alignment)))
        (sps:and
          node
          (begin
            (sps->c::val:tag! node sps->c::val:tag-value)
            (sps->c::state:forward-val-decl! state node)
            #t))
        node))))


;
; All this does is prime the symbol table with the binding, it does
; not actually generate any C code.  This is because it is really only
; meant to be used to declare static vectors which themselves take
; care of outputting a forward declaration in the preamble.
;
(define (sps->c::do-expr-define-forward-val define-node state id-node)
  (let* ((st (sps->c::state:symbol-table state))
         (mp (sps->c::state:main-port state))
         (id (sps:ast:value id-node))
         (st-node (sps:symbol-table:enter st id id-node)))
    (sps:and
      st-node
      (or (sps:symbol-table:node:new? st-node)
          (sps->c::report-duplicate-definition define-node id-node st-node))
      (sps->c::error-if-junk-at-forward-end id-node)
      ; id-node is just an arbitrary non-zero value
      (let ((vn (sps->c::make-val-node state #t)))
        (sps:and
          vn
          (begin (sps:symbol-table:node:value! st-node vn) #t))))))


(define (sps->c::do-expr-define-forward-fun define-node state list-node)
  (let ((st (sps->c::state:symbol-table state))
        (mp (sps->c::state:main-port state))
        (id-node (sps:ast:value list-node)))
    (sps:and
      (sps->c::error-if-not-id id-node state)
      (let* ((id (sps:ast:value id-node))
             (st-node (sps:symbol-table:enter st id id-node)))
        (sps:and
          st-node
          (or (sps:symbol-table:node:new? st-node)
              (sps->c::report-duplicate-definition define-node id-node st-node))
          (sps:symbol-table:open-scope st)
          (sps->c::output-fun-name st-node state)
          (let* ((args-node (sps:ast:next id-node))
                 (proc (sps->c::do-define-fun-args args-node state #t "sps_val ")))
            (sps:and
              proc 
              (begin (sps:symbol-table:node:value! st-node proc) #t)))))
      (sps:io:print:string mp ";")
      (sps:io:newline mp)
      (sps->c::error-if-junk-at-forward-end list-node)
      (begin (sps:symbol-table:close-scope st) #t))))


(define (sps->c::do-expr-define-forward define-node state)
  (let ((name-node (sps:ast:next define-node)))
    (cond ((sps->c::list? name-node)
           (sps->c::do-expr-define-forward-fun define-node state name-node))
          ((sps->c::id? name-node)
           (sps->c::do-expr-define-forward-val define-node state name-node))
          (else 
            (sps->c::error:start name-node "malformed_define_forward")
            (sps->c::error:node-arg define-node)
            (sps->c::error:end)))))


;
; This dumps out the actual header to the main port and also a forward
; declaration to the preamble port.  Due to a pecularity of C you cannot
; forward declare a static (array), you need to first declare it with
; exteral linkage (ugh!).  Is this true?
;
(define (sps->c::do-expr-define-static-vector-list-header st-node state)
  (let ((mp (sps->c::state:main-port state))
        (pp (sps->c::state:preamble-port state))
        (real-id (sps:symbol-table:node:id st-node))
        (generated-id (sps:symbol-table:node:unique-id st-node)))
    (sps:and
      (sps:io:print:string mp "/* ")
      (sps:io:print:string pp "/* ")
      (sps->c::display-id real-id mp)
      (sps->c::display-id real-id pp)
      (sps:io:print:string mp " */")
      (sps:io:newline mp)
      (sps:io:print:string mp "static const sps_val ")
      (sps:io:print:string pp " */")
      (sps:io:newline pp)
      (sps:io:print:string pp "static const sps_val ")
      (sps->c::output-generated-id generated-id mp)
      (sps->c::output-generated-id generated-id pp)
      (sps:io:print:string mp "[] = {")
      (sps:io:print:string pp "[];")
      (sps:io:newline pp))))



(define (sps->c::do-expr-define-static-vector-exprs expr-list-node state)
  (let ((mp (sps->c::state:main-port state)))
    (let loop ((expr (sps:ast:value expr-list-node)) (sep ""))
      (sps:if expr
          (sps:and
            (sps:io:print:string mp sep)
            (sps:io:newline mp)
            (sps:io:print:string mp "(sps_val)")
            (sps->c::do-expr expr state)
            (loop (sps:ast:next expr) ","))
          (sps:and
            (sps:io:print:string mp "};")
            (sps:io:newline mp))))))

;
; (define-static-vector <variable> <size>)
;
; XXX: should really check that <size> is a static expression.
;
(define (sps->c::do-expr-define-static-vector-fixed st-node state expr)
  (let ((mp (sps->c::state:main-port state))
        (pp (sps->c::state:preamble-port state))
        (real-id (sps:symbol-table:node:id st-node))
        (generated-id (sps:symbol-table:node:unique-id st-node)))
    (sps:and
      (sps:io:print:string mp "/* ")
      (sps->c::display-id real-id mp)
      (sps:io:print:string mp " */")
      (sps:io:newline mp)
      (sps:io:print:string mp "static sps_val ")
      (sps->c::output-generated-id generated-id mp)
      (sps:io:print:string mp "[")
      (sps->c::do-expr expr state)
      (sps:io:print:string mp "];")
      (sps:io:newline mp))))


;
; (define-static-vector <variable> <size>)
; (define-static-vector <variable> <expr> ...)
;
(define (sps->c::do-expr-define-static-vector-body define-node state 
                                                   id-node st-node)
  (let ((next-node (sps:ast:next id-node)))
    (sps:if next-node
        (cond ((sps->c::list? next-node)
               (sps:and
                 (sps->c::do-expr-define-static-vector-list-header st-node
                                                                   state)
                 (sps->c::do-expr-define-static-vector-exprs next-node state)))
              ((or (sps->c::id? next-node) (sps->c::int? next-node))
               (sps->c::do-expr-define-static-vector-fixed st-node state next-node))
              (else
               (sps->c::error:start next-node "malformed_define-static-vector")
               (sps->c::error:node-arg define-node)
               (sps->c::error:node-arg id-node)
               (sps->c::error:end)))
        (begin
          (sps->c::error:start define-node "missing_define-static-vector_body")
          (sps->c::error:node-arg id-node)
          (sps->c::error:end)))))



;
; Note that it overwrites the symbol table value with an arbitrary
; (non-zero) value once it is found to be compatible.
;
(define (sps->c::compatible-forward-val-decl? st-node)
  (let ((v (sps:symbol-table:node:value st-node)))
    (sps:and
      (sps->c::val? v)
      (sps->c::val:forward? v)
      (begin (sps:symbol-table:node:value! st-node st-node) #t))))


(define (sps->c::do-expr-define-static-vector define-node state)
  (let ((st (sps->c::state:symbol-table state))
        (mp (sps->c::state:main-port state))
        (id-node (sps:ast:next define-node)))
    (sps:and
      (sps->c::error-if-not-id id-node state)
      (let* ((id (sps:ast:value id-node))
             (st-node (sps:symbol-table:enter st id id-node))
             (exprs (sps:ast:next id-node)))
        (sps:and
          st-node
          (sps:or
            (sps:symbol-table:node:new? st-node)
            (sps->c::compatible-forward-val-decl? st-node)
            (sps->c::report-duplicate-definition define-node id-node st-node))
          (sps->c::do-expr-define-static-vector-body define-node state id-node st-node)
          ; the use of define-node is fairly arbitary.
          (begin (sps:symbol-table:node:value! st-node define-node) #t))))))


(define-static-vector sps->c::syntax-literals
  (sps->c::literal:and                  sps->c::do-expr-and
   sps->c::literal:begin                sps->c::do-expr-begin
   sps->c::literal:case                 sps->c::do-expr-case
   sps->c::literal:cond                 sps->c::do-expr-cond
   sps->c::literal:define               sps->c::do-expr-define
   sps->c::literal:define-external      sps->c::do-expr-define-external
   sps->c::literal:define-forward       sps->c::do-expr-define-forward
   sps->c::literal:define-static-vector sps->c::do-expr-define-static-vector
   sps->c::literal:else                 sps->c::do-expr-else
   sps->c::literal:if                   sps->c::do-expr-if
   sps->c::literal:let                  sps->c::do-expr-let
   sps->c::literal:let*                 sps->c::do-expr-let*
   sps->c::literal:or                   sps->c::do-expr-or))

(define sps->c::n-syntax-literals 13)

(define (sps->c::prime-symbol-table state)
  (let ((ht (sps->c::state:hash-table state))
        (st (sps->c::state:symbol-table state))
        (end (* 2 sps->c::n-syntax-literals)))
    (let loop ((i 0))
      (or (= i end)
          (let* ((string (sps:word-vector:ref sps->c::syntax-literals i))
                 (action (sps:word-vector:ref sps->c::syntax-literals (+ i 1)))
                 (len (sps:string:length string))
                 (hv (sps:hash:string-literal string 0 len))
                 (ht-node (sps:hash-table:enter ht string 0 len hv)))
            (sps:and
              ht-node
              (begin
                (sps:assert (sps:hash-table:node:new? ht-node))
                (let ((st-node (sps:symbol-table:enter st string 0))
                      (syntax (sps->c::make-syntax-node state action)))
                  (sps:and
                    st-node
                    syntax
                    (begin
                      (sps:hash-table:node:string! ht-node string)
                      (sps:symbol-table:node:value! st-node syntax)
                      (loop (+ i 2))))))))))))
  

(define (sps->c:state:open state pools hash-table symbol-table
                           main-port preamble-port)
  (let ((sp (sps:mem:sp:obtain pools)))
    (sps:and
      sp
      (begin
        (sps->c::state:tag! state sps->c::state:tag-value)
        (sps->c::state:hash-table! state hash-table)
        (sps->c::state:symbol-table! state symbol-table)
        (sps->c::state:stack-pool! state sp)
        (sps->c::state:preamble-port! state preamble-port)
        (sps->c::state:main-port! state main-port)
        (sps->c::state:string-literal-count! state 0)
        (sps->c::state:binding-depth! state 0)
        (sps->c::state:forward-val-decl! state 0)
        #t)
      (sps:symbol-table:open-scope symbol-table)
      (sps->c::prime-symbol-table state)
      (sps:symbol-table:open-scope symbol-table))))


(define (sps->c::locate-main state)
  (let ((ht (sps->c::state:hash-table state))
        (st (sps->c::state:symbol-table state)))
    (let* ((main "main")
           (main-len 4)
           (hv (sps:hash:string-literal main 0 main-len))
           (ht-node (sps:hash-table:enter ht main 0 main-len hv)))
      (sps:and
        ht-node
        (not (sps:hash-table:node:new? ht-node))
        (sps:symbol-table:lookup st (sps:hash-table:node:string ht-node))))))

(define (sps->c::report-main-not-proc main-node)
  (sps->c::error:start main-node "main_not_a_proc")
  (sps->c::error:end))

(define (sps->c::report-main-not-defined root)
  (sps->c::error:start root "missing_main_definition")
  (sps->c::error:end))

(define (sps->c::report-main-wrong-arity main-node arity)
  (sps->c::error:start main-node "main_takes_two_arguments")
  (sps->c::error:int-arg arity)
  (sps->c::error:end))


(define (sps->c::output-main state root)
  (let ((main (sps->c::locate-main state))
        (mp (sps->c::state:main-port state)))
    (sps:and
      (sps:or main (sps->c::report-main-not-defined root))
      (let ((proc (sps:symbol-table:node:value main))
            (gid (sps:symbol-table:node:unique-id main))
            (main-node (sps:symbol-table:node:source main)))
        (sps:and
          (sps:or (sps->c::proc? proc)
                  (sps->c::report-main-not-proc main-node))
          (let ((arity (sps->c::proc:n-args proc)))
            (sps:or (= 2 arity)
                    (sps->c::report-main-wrong-arity main-node arity)))
          (sps:io:print:string mp "int main(int argc, char **argv)")
          (sps:io:newline mp)
          (sps:io:print:string mp "{")
          (sps:io:newline mp)
          (sps:io:print:string mp "return ")
          (sps->c::output-generated-id gid mp)
          (sps:io:print:string mp "((sps_val)argc, (sps_val)argv);")
          (sps:io:newline mp)
          (sps:io:print:string mp "}")
          (sps:io:newline mp))))))

                
(define (sps->c state root)
  (let loop ((expr root))
    (sps:if expr
        (sps:and
          (sps->c::do-expr expr state)
          (loop (sps:ast:next expr)))
        (let ((st (sps->c::state:symbol-table state)))
          (sps->c::output-main state root)
          (sps:symbol-table:close-scope st)
          (sps:symbol-table:close-scope st)
          (sps:io:close (sps->c::state:preamble-port state))
          (sps:io:close (sps->c::state:main-port state))
          #t))))
