<?php

// Обычную функцию можно вызвать до ее определения в коде
echo f('Сергей');

// Здесь будет ошибка
$f2();

function f(string $name): string
{
    return "Hello from function, ${name}\n";
}

$f2 = function () { echo "Другая функция"; };

