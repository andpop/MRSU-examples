function sum(a, b) {
   return this.prop + a + b;
}

function f() {
    console.log('this in function f():', this);
    console.log('this.prop=',this.prop);
};

const a = {
    prop: 1
}

const b = {
    prop: 2
}


f();

const f2 = f.bind(a);
f2();

const f3 = f.bind(b);
f3();

let n = sum.call(a, 1, 2);
console.log({n});

n = sum.call(b, 1, 2);
console.log({n});
