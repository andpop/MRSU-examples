class Person {
    constructor(last, first) {
        this.last = last;
        this.first = first;
    };

    get fullName() { return `${this.last}, ${this.first}` };

    set fullName(value){
        // const names = value.split(' ');
        // this.first = names[0];
        // this.last = names[1];

        [this.first, this.last] = value.split(' ');
    };
}

const bond = new Person('Bond', 'James');
const name = bond.fullName;
console.log({name});

bond.fullName = 'John Dow';

console.log({bond});

