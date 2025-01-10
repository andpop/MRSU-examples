// Function Declaration
function sum(a, b) {
   return a + b;
}

// Function Expression
var mult = function(a, b) {
   return a * b;
}

// Анонимная функция
function fn(filter) {
   filter();
}

fn(function() {
   console.log('!!!');
});

// Стрелочные функции
var sum2 = (a, b) => {
   return a + b;
};

var result = sum2(10, 20);
console.log(result);

// Самый краткий вариант
var sum3 = (a, b) => a + b;
