console.log('===== Object literal =========================================');
console.log();

const bond = {
    name: 'James Bond',
    salary: 50000,
    raiseSalary(percent) {
        console.log('this до: ', this);
        this.salary *= (1 + percent / 100);
        console.log('this после: ', this);
    }
};
console.log(bond.name, bond['salary']);
bond.raiseSalary(10);

console.log();
console.log('===== Object.create() =========================================');
console.log();

const bond2 = Object.create(bond);  // [[Prototype]] -> bond
console.log({bond2});

console.log(bond2.name, bond2['salary']);
bond2.raiseSalary(10);


console.log();
console.log('===== new  =========================================');
console.log();

function Employee(name, salary) {
    console.log('this in constructor: ', this);
    this.name = name;
    this.salary = salary;
}

Employee.prototype.raiseSalary = function (percent) {
    console.log('this до: ', this);
    this.salary *= 1 + percent / 100;
    console.log('this после: ', this);
};

bond3 = new Employee("James Bond", 100000);
bond3.raiseSalary(10);
console.log(bond3.constructor);

// 1. new создает новый пустой объект {}
// 2. this связывается с этим объектом
// 3. В этом объекте [[Prototype]] -> Employee.prototype
// 4. Employee.prototype.consctructor = Employee
// 4. Запускается функция-конструктор Employee, в которой через this могут инициалироваться свойства объекта.
// 5. Объект, на который указывает this, автоматически возвращается из функции-конструктора и присваивается переменной.

