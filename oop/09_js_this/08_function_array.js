const obj = {
    a: [],
    f() {console.log(this)},
    g: () => {console.log(this)}
};

obj.a.push(function () {console.log(this)});
obj.a.push(() => {console.log(this)});
obj.a.push(obj.f);
obj.a.push(obj.g);
obj.a[0]();
obj.a[1]();
obj.a[2]();
obj.a[3]();
console.log('--------------------');
obj.f();
obj.g();

function F() {
    this.ff = function() {console.log(this)};
    this.gg = () => {console.log(this)};
};

const f = new F();
f.ff();
f.gg();

