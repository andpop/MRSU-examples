function createEmployee(name, salary) {
  return {
    getName: () => name,
    raiseSalary: (percent) => {
      salary *= 1 + percent / 100;
    },
    getSalary: () => salary,
  };
}

const bond = createEmployee("James Bond", 100000);
console.log(bond.getSalary());

console.log({ bond });

// console.log(bond.getName());
// console.log(bond.getSalary());

bond.raiseSalary(15);
console.log(bond.getSalary());

// bond.raiseSalary(20);
// console.log(bond.getSalary());
