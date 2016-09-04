#|
@doc
  cowboy-coding public API
@end
|#

(defmodule cowboy-coding-app
  (behaviour application)

  ;; Application callbacks
  (export (start 2)
          (stop 1)))

;;; API

(defun start (_type _args)
  (let* ((dispatch (cowboy_router:compile (router-match-spec)))
	 (`#(ok ,_pid)
	  (cowboy:start_http
	   'lfe_http_listener
	   100
	   '(#(port 8080))
	   `(#(env (#(dispatch ,dispatch)))))))
    (cowboy-coding-sup:start_link)))

(defun stop (_state)
  'ok)

;;; Internal functions

(defun router-match-spec ()
  "Returns the match spec we will be using for our router"
  '(#(_ (#("/" cowboy-coding-handler ())))))