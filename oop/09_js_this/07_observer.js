class BankAccount {
    constructor() {
        this.balance = 0
        this.observers = []
    }

    addObserver(f) {
        this.observers.push(f)
    }

    notifyObservers() {
        for (let i = 0; i < this.observers.length; i++) {
            console.log(this)
            this.observers[i]()
        }
    }

    deposit(amount) {
        this.balance += amount
        this.notifyObservers()
    }
}

class User {
    log(message) {
        console.log(message)
    }

    start() {
        acct.addObserver(() => { 
            console.log(this);
            this.log('Еще денег!') 
        });
        // acct.addObserver(function() { 
        //     console.log(this);
        //     this.log('Еще денег!') 
        // })
        acct.deposit(1000)
    }
}

const acct = new BankAccount()
const user = new User()

user.start()
