const a = {
    prop: 1,
    f() {
        console.log('this.prop=',this.prop);
    }
}

function doFunc(fn) {
    fn(); // Место вызова
}

a.f();  // 1

// Косвенная ссылка - для this действует правило связывания по умолчанию
const func = a.f;
func(); // undefined


// Потеря связываения this в коллбэках
doFunc(a.f);

setTimeout(a.f, 100);  // undefined


// Потеря связывания this во внутренней функции
const obj = {
    prop: 1,
    f() {
        const internalFunc = function() {
            console.log('internal this.prop=',this.prop);
        };

        console.log('external this.prop=',this.prop);

        internalFunc();
    }
};

obj.f();
