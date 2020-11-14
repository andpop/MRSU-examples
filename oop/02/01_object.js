let dog = {
    name: "Барбос",
    age: 5,
    say: function() {
        console.log(`Гав-гав! Меня зовут ${this.name}!`);
    }
};

dog.say();

dog.name = "Шарик";
dog.say();