#lang racket

(require urlang urlang/extra)

(current-urlang-run?                           #f) ; don't use node to run this 
(current-urlang-echo?                          #t) ; print output JavaScript
; (current-urlang-console.log-module-level-expr? #t) ; print result of top level expressions
;                                                  ; to the JavaScript console

(urlang
    (urmodule demo-sum
      (export sum)                                 ; sum is exported
      (define (even? x) (=== (% x 2) 0))
      (var (sum 0) x (a (array 1 2 3 4 5)) (i 0) (n a.length))
      (while (< i n)
        (:= x (ref a i))
        (cond
          [(even? x)  (+= sum (ref a i))]
          [else       "skip"])
        (+= i 1))
      sum))

;;; Running the program will create a file "demo-sum.js" containing:

; "use strict";
; function even_p(x_1){return ((x_1%2)===0);};
; var sum=0,x,a=[1,2,3,4,5],i=0,n=a.length;
; while((i<n)){(x=a[i]);(((even_p(x))===false)?((function(){return "skip";})()):((function(){return (sum+=a[i]);})()));(i+=1);};
; console.log(sum);
; exports.sum=sum;
