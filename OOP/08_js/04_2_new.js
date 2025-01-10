const F = function () {
  console.log("Функция F");
};

const obj = new F();

console.log(obj);
console.log(F.prototype === Object.getPrototypeOf(obj)); // true
