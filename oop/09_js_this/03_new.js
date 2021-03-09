'use strict'

const A = function() {
    const f = function() {
        console.log(this);
    }

    console.log(this);
    this.prop = 1;
    console.log(this);

    f();
}

const a = new A();

