function Employee(name, salary) {
    this.name = name;
    this.salary = salary;
    // return {a: 1, b: 2};
};

Employee.prototype.raiseSalary = function(percent) {
    this.salary *= 1 + percent / 100;
};

bond = new Employee('James Bond', 100000);
console.log({bond});

// bond.raiseSalary(10);
// console.log({bond});
