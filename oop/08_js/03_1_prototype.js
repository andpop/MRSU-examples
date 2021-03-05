const a = { n: 1 };
const b = { m: 2 };

Object.setPrototypeOf(a, b);

const c = Object.getPrototypeOf(a);

console.log(c);
console.log(a.m);

// const d = Object.create(b);

// console.log({d});
// console.log(d.m);
