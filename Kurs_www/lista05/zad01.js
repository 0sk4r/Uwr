// pierwsza "kropka" działa poprawnie, chyba o to chodziło
"use strict";
var testObj = Object.defineProperties({}, {
    prop1: {
        value: 10,
        writable: false // by default
    },
    prop2: {
        get: function () {
        }
    }
});
console.log(testObj.prop1); 
console.log(testObj.prop2);
function Point(x, y) {
this.x = x;
this.y = y;
}
// Methods
Point.prototype.dist = function () {
return Math.sqrt(this.x*this.x + this.y*this.y);
};
var p = new Point(3, 5);
console.log(p.x);
console.log(p.dist());
//"druga" kropa; jak wpiszemu 'use strict'; to nie działa; jak usuniemy, to działa
function answer()
{
a = 1
b = 10
c = -50
root = Math.pow(b, 2) - 4 * a * c
answer1 = (-b + Math.sqrt(root)) / 2*a
answer2 = (-b - Math.sqrt(root)) / 2*a
     if(root<'0')
     {
     alert('This equation has no real solution.');
     }else{
              if(root=='0')
              {          
              console.log(answer1)
              alert('No second answer');
              }else{
                   console.log(answer1)
                   console.log(answer2)
                   }
          }
}
answer();
function f()
{ 
   console.log(010);
}
f();
function fun(a, b)
{
  
  var v = 12;
  return arguments.caller; // throws a TypeError
}
console.log(fun(1, 2)); // doesn't expose v (or a or b)