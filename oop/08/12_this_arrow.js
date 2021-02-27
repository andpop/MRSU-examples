const a = {
    prop: 1,
    f() {
        const internalFunc = function() {
            console.log('internal this.prop=',this.prop);
        };

        console.log('external this.prop=',this.prop);

        internalFunc();
    }
};

const b = {
    prop: 1,
    f() {
        const internalFunc = () => {
            console.log('internal this.prop=',this.prop);
        };

        console.log('external this.prop=',this.prop);

        internalFunc();
    }
};


a.f();  

console.log('-----------');

b.f();

