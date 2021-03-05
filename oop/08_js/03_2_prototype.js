const employeePrototype = {
  raiseSalary(percent) {
    this.salary *= 1 + percent / 100;
  },
};

function createEmployee(name, salary) {
  const result = { name, salary };
  Object.setPrototypeOf(result, employeePrototype);

  return result;
}

// // ----------------------------------------------
const bond1 = createEmployee("James Bond", 100000);
const bond2 = createEmployee("John Bond", 45000);

console.log({ bond1 });
console.log({ bond2 });

// console.log(bond1.raiseSalary === bond2.raiseSalary)
// // ----------------------------------------------
// bond1.raiseSalary(10);
// console.log({bond1});

// // ----------------------------------------------
bond1.raiseSalary = function (percent) {
  this.salary = Number.MAX_VALUE;
};

bond1.raiseSalary(10);
console.log({ bond1 });

bond2.raiseSalary(10);
console.log({ bond2 });
