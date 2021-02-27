
class Employee {
    constructor (name, salary) {
        this.name = name;
        this.salary = salary;
    };

    raiseSalary(percent) {
        this.salary *= 1 + percent / 100;
    };
}

class Manager extends Employee {
    constructor (name, salary, bonus) {
        super(name, salary);
        this.bonus = bonus;
    };

    getSalary() { return this.salary + this.bonus }
}

const employee = new Employee('James Bond', 100000);
console.log({employee});

const manager = new Manager('John Doe', 200000, 50000);
console.log({manager});
