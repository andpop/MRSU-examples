function f() {
    console.log('this in function f():', this);
    console.log('this.prop=',this.prop);
};

const a = {
    prop: 1,
    f
}

const b = {
    prop: 2,
    f
}


f();

console.log('======================================');

a.f()  // 1
a['f']()  // 1

console.log('======================================');

b.f()

