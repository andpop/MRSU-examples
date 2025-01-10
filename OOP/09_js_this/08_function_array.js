const obj = {
    a: [],
};

obj.a.push(function () {console.log(this)});
obj.a.push(() => {console.log(this)});
obj.a[0]();
obj.a[1]();
