const bond = {
    name: 'James Bond', 
    salary: 50000,
    raiseSalary: function(percent) {
        console.log('this=', this);
        this.salary *= (1 + percent / 100);
    }
};

bond.raiseSalary(10);

// const badThis = {
//     salary: 100000,
//     raiseSalary: percent => {
//         console.log('this=', this);
//         this.salary *= (1 + percent / 100);
//     }
// };

// badThis.raiseSalary(10);

