class Employee {
    constructor (name, salary) {
        this.name = name;
        this.salary = salary;
    };

    raiseSalary(percent) {
        this.salary *= 1 + percent / 100;
    };
}

bond = new Employee('James Bond', 100000);
console.log({bond});

bond.raiseSalary(10);
console.log({bond});
