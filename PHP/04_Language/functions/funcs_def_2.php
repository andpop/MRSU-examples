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

echo gettype($greet) . PHP_EOL;
//===================================================

sayHello("Иван");

$f = 'sayHello';
$f('Вася');
"sayHello"("Петя");

$rand = "rand";
echo $rand(0, 5) . PHP_EOL;

/* $greet("Анна"); */
/* echo $double(5) . "\n"; */

/* echo calculateTax(100) . "\n";     // Выведет: 18 */
/* echo calculateTax(100, 0.05) . "\n"; // Выведет: 5 */

/* echo sum(1, 2, 3, 4, 5) . "\n"; // Выведет: 15 */

/* echo addNumbers(2.5, 3.5); // Выведет: 6 */
