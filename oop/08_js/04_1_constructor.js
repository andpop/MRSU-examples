function Employee(name, salary) {
  this.name = name;
  this.salary = salary;
  // return {a: 1, b: 2};
}

Employee.prototype.raiseSalary = function (percent) {
  this.salary *= 1 + percent / 100;
};

bond = new Employee("James Bond", 100000);
// console.log({ bond });

// console.log(Object.getPrototypeOf(bond));
// bond.raiseSalary(12);
// console.log({ bond });
//
//
// console.log(Employee.prototype.constructor);
// console.log(bond.constructor);
//
