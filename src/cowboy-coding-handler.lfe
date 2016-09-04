(defmodule cowboy-coding-handler
  (export all))

(defun init (_type req opts)
  `#(ok ,req 'no-state))

(defun handle (req state)
  (let ((`#(ok ,res) (cowboy_req:reply
		       200
		       '(#(#"content-type" #"text/plain"))
		       #"Hello, LFE!"
		       req)))
    `#(ok ,res 'still-no-state)))

(defun terminate (_reason _req _state)
  'ok)
