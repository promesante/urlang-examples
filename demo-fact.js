"use strict";
function fact(n){return (((n===0)===false)?(n*(fact((n-1)))):1);};
((console.log)((fact(5))));
exports.fact=fact;
