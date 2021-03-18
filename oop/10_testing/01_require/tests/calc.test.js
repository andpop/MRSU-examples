// calc.test.js
const Calc = require('../src/calc');
const calc = new Calc();

test('sum', () => {
    expect(calc.sum(2, 5)).toBe(7);
});

test('diff', () => {
    expect(calc.diff(2, 5)).toBe(-3);
});


describe('div', () => {
    test('деление', () => {
        expect(calc.div(10, 5)).toBe(2);
    });

    // test('на 0', () => {
    //     expect(calc.div(10, 0)).toBe(10);
    // });

    // test('без второго аргумента', () => {
    //     expect(calc.div(10)).toBe(10);
    // });

    test('на не число', () => {
        expect(calc.div(10, 'sdfdfdf')).toBe(10);
        expect(calc.div(10, {})).toBe(10);
        expect(calc.div(10, Infinity)).toBe(10);
        expect(calc.div(10, false)).toBe(10);

    });

});
