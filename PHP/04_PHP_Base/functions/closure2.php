<?php

function outer()
{
    echo "Hello from outer\n";

    function inner()
    {
        echo "Hello from inner\n";
    }

    inner();
}

outer();
inner(); // Функция inner попала в глобальную область видимости

outer(); // Будет ошибка - функция inner уже определена

//-------------------------------------------------------------
// Вложенная функция как замыкание
function outerFunction() {
    $innerFunction = function() {
        echo "Я замкнутая функция.";
    };

    $innerFunction(); // Вызываем замкнутую функцию внутри внешней
}

outerFunction();
outerFunction(); // Функцию outer можно вызвать несколько раз

$innerFunction(); // Ошибка: Функция не определена
