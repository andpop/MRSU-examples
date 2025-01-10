function f() {
    console.log(this.a);
    console.log(this.d);
};

var a = 1;
exports.b = 2;
module.exports.c = 3;

global.d = 4;

console.log(this)
f();

