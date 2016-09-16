"use strict";
function fibo(n){return (((n===0)===false)?(((n===1)===false)?((function(){return ((fibo((n-1)))+(fibo((n-2))));})()):((function(){return 1;})())):((function(){return 1;})()));};
((console.log)((fibo(7))));
exports.fibo=fibo;
