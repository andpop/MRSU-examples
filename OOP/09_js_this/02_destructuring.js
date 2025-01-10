let name = 'Иван',
    age = 25;

// Сокращенная запись объектного литерала
const obj1 = {name: name, age: age}
const obj2 = {name, age}

// console.log(obj1)
// console.log(obj2)

// Деструктуризация по объекту
const obj3 = {name: 'Мария', age: 20};
// name = obj3.name;
// age = obj3.age;
({name, age} = obj3)
console.log({name});
console.log({age});

let {name: name2, age: age2} = obj3;
console.log({name2});
console.log({age2});


// Значения по умолчанию
let config = { separator: '; ' };
const { 
    separator = ',', 
    leftDelimiter = '[', 
    rightDelimiter = ']' 
} = config;
console.log({separator})
console.log({leftDelimiter})
console.log({rightDelimiter})

// spread-оператор
const o1 = {a: 1, b: 2}
const o2 = {c: 3, d: 4, e: 5}
const o3 = {...o1, ...o2}

console.log(o3)
