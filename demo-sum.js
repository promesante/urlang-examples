"use strict";
function even_p(x_1){return ((x_1%2)===0);};
var sum=0,x,a=[1,2,3,4,5],i=0,n=a.length;
while((i<n)){(x=a[i]);(((even_p(x))===false)?((function(){return "skip";})()):((function(){return (sum+=a[i]);})()));(i+=1);};
sum;
exports.sum=sum;
