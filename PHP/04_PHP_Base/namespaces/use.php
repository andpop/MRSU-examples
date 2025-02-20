<?php
// Глобальное пространство имен
function sayHello() {
    echo "Hello from global namespace\n";
}

const APP_NAME = "Global App";

// Пространство имен MyNamespace
namespace MyNamespace;

function sayHello() {
    echo "Hello from MyNamespace\n";
}

const APP_NAME = "MyNamespace App";

// Импорт функции и константы из глобального пространства имен
use function \sayHello as globalSayHello;
use const \APP_NAME as GLOBAL_APP_NAME;

// Вызов импортированной функции
globalSayHello(); // Выведет: Hello from global namespace

// Вывод импортированной константы
echo GLOBAL_APP_NAME . "\n"; // Выведет: Global App

// Вызов функции из MyNamespace
sayHello(); // Выведет: Hello from MyNamespace

// Вывод константы из MyNamespace
echo APP_NAME . "\n"; // Выведет: MyNamespace App
?>
