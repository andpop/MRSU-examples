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
inner();

//-------------------------------------------------------------
// Вложенная функция как замыкание
function outerFunction() {
    $innerFunction = function() {
        echo "Я замкнутая функция.";
    };

    $innerFunction(); // Вызываем замкнутую функцию внутри внешней
}

outerFunction(); // Внутреннюю функцию нельзя вызвать снаружи
$innerFunction(); // Ошибка: Функция не определена
