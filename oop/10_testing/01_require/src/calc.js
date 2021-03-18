// src/calc.js
class Calc {
    sum(a, b) {
        return a + b;
    }

    diff(a, b) {
        return a - b;
    }

    div(a, b) {
        if (!b || !isFinite(b)) {
            b = 1;
        }

        return a / b;
    }
}

module.exports = Calc;

