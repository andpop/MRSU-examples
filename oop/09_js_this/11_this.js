const a = {
    prop: 1,
    f() {
        console.log('this.prop=',this.prop);
    }
}

a.f();  // 1
a['f']();  // 1

const func = a.f;
func(); // undefined

// setTimeout(a.f, 100);  // undefined

console.log('-----------------------------------');

const func2 = a.f.bind(a);
func2();
