(defmacro sps:assert (expr)
  `(let ((sjb:expr ,expr))
     (if (or (and (integer? sjb:expr) (zero? sjb:expr)) (not sjb:expr))
         (error 'assertion-failure ',expr))))
