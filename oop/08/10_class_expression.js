
const Employee = class {
    constructor (name, salary) {
        this.name = name;
        this.salary = salary;
    };

    raiseSalary(percent) {
        this.salary *= 1 + percent / 100;
    };
}

const withToString = base => 
    class extends base {
        toString() {
            let result = '{';
            for (const key in this) {
                if (result !== '{') result += ', ';
                result += `${key}=${this[key]}`;
            };
            return result + '}';
        };
    };

const e1 = new Employee('Harry Smith', 90000);
console.log(e1.toString());  // [object Object]


const PrettyPrintingEmployee = withToString(Employee); // новый класс
const e2 = new PrettyPrintingEmployee('Harry Smith', 90000); // экземпляр нового класса
console.log(e2.toString());  // {name=Harry Smith, salary=90000}
