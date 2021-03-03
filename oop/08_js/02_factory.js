function createEmployee(name, salary) {
    return {
        name,
        salary,
        // У каждого объекта будет своя функция
        raiseSalary(percent) {
            this.salary *= (1 + percent / 100);
        }
    };
};

const bond1 = createEmployee('James Bond', 100000);
const bond2 = createEmployee('John Bond', 45000);

console.log({bond1});
console.log({bond2});

// const f1 = bond1.raiseSalary;
// const f2 = bond2.raiseSalary;

// console.log(f1 === f2);
