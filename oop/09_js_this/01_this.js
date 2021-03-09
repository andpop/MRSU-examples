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


a.f()  // 1
a['f']()  // 1

console.log('-------------------')
b.f()

console.log('-------------------')
const func = a.f;
func(); // undefined

