function sum(a, b) {
   return this.prop + a + b;
}

const a = {
    prop: 1,
    f() {
        console.log('Function f from object a');
        console.log('this.prop=',this.prop);
    }
}

const b = {
    prop: 2,
    f() {
        console.log('Function f from object b');
        console.log('this.prop=',this.prop);
    }
}


const func = a.f;
func(); // undefined

const func2 = func.bind(a);
func2();

const func3 = func.bind(b);
func3();

let n = sum.call(a, 1, 2);
console.log({n});

n = sum.call(b, 1, 2);
console.log({n});
