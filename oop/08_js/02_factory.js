function createEmployee(name, salary) {
  return {
    name,
    salary,
    // У каждого объекта будет своя функция
    raiseSalary(percent) {
      this.salary *= 1 + percent / 100;
    },
  };
}

const bond1 = createEmployee("James Bond", 100000);
const bond2 = createEmployee("John Bond", 45000);

console.log({ bond1 });
console.log({ bond2 });

// console.log(bond1.raiseSalary === bond1.raiseSalary2);
