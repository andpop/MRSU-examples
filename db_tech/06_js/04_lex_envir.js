// Лексическое окружение
var a = 10;

function fn1(b, c) {
   function fn2(d, e) {
       return a + b + c + d + e;
   }

   return fn2(3,4);
}

fn1(1,2);  // 20

// ----------------------------------------------
let name = "John";

function sayHi() {
  alert("Hi, " + name);
}

name = "Pete"; // (*)

sayHi(); 