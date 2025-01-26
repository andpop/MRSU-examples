<?php
echo "Начало программы\n";

try {
    echo "Начало try-блока\n";
    outer();
    echo "Конец try-блока\n";
} catch (Exception $e) {
    echo " Исключение: {$e->getMessage()}\n";
}

echo "Конец программы\n";

function outer() {
    echo "Вошли в функцию ".__METHOD__."\n";
    inner();
    echo "Вышли из функции ".__METHOD__."\n";
}

function inner() {
    echo "Вошли в функцию ".__METHOD__."\n";
    throw new Exception("Hello!");
    echo "Вышли из функции ".__METHOD__."\n";
}
