class BankAccount {
    constructor() {
        this.balance = 0
        this.observers = []
    }

    addObserver(f) {
        this.observers.push(f)
    }

    notifyObservers(msg) {
        for (let i = 0; i < this.observers.length; i++) {
            this.observers[i](msg)
        }
    }

    deposit(amount) {
        this.balance += amount
        this.notifyObservers(`Пополнение баланса на ${amount}`);
    }
}

class User {
    log(message) {
        console.log(message)
    }

    start() {
        // acct.addObserver(msg => { 
        //     this.log(msg) 
        // });
        acct.addObserver(function(msg) { 
            this.log(msg) 
        })
        acct.deposit(1000)
    }
}

const acct = new BankAccount()
const user = new User()

user.start()
