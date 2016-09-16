#lang racket

(require urlang urlang/extra)

(current-urlang-run?                           #t) ; don't use node to run this 
; (current-urlang-echo?                          #t) ; print output JavaScript
; (current-urlang-console.log-module-level-expr? #t) ; print result of top level expressions
;                                                  ; to the JavaScript console

(urlang
 (urmodule demo-fibo                               ; module name
   (export fibo)                                   ; fibo is exported
   (define (fibo n)
     (cond
       [(= n 0) 1]
       [(= n 1) 1]
       [else (+ (fibo (- n 1)) (fibo (- n 2)))]))
   (console.log (fibo 7))))

;;; Running the program will create a file "demo-fibo.js" containing:

;  "use strict";

; "use strict";
; function fibo(n){return (((n===0)===false)?(((n===1)===false)?((function(){return ((fibo((n-1)))+(fibo((n-2))));})()):((function(){return 1;})())):((function(){return 1;})()));};
; console.log(((console.log)((fibo(7)))));
; exports.fibo=fibo;
