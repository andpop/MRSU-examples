// TODO: доделать


class BankAccount {
    #balance = 0;

    deposit(amount) { this.#balance += amount }

    showBalance() { console.log(this.#balance) }
}

const account = new BankAccount;

account.deposit(100);

account.showBalance();
