<?php

declare(strict_types=1);

//Обычная функция
function sayHello($name)
{
    echo "Привет, $name!\n";
}

//Анонимная функция
$greet = function ($name) {
    echo "Здравствуйте, $name!\n";
};

//Стрелочная функция
$double = fn($x) => $x * 2;

// Параметры по умолчанию
function calculateTax($amount, $taxRate = 0.18)
{
    return $amount * $taxRate;
}

// Переменное количество аргументов
function sum(...$numbers)
{
    return array_sum($numbers);
}

// Задание типов аргуменитов и возвращаемого значения
function addNumbers(float $a, float $b): float
{
    return $a + $b;
}

//===================================================

sayHello("Иван");
$greet("Анна");
echo $double(5) . "\n";

echo calculateTax(100) . "\n";     // Выведет: 18
echo calculateTax(100, 0.05) . "\n"; // Выведет: 5

echo sum(1, 2, 3, 4, 5) . "\n"; // Выведет: 15

echo addNumbers(2.5, 3.5); // Выведет: 6
