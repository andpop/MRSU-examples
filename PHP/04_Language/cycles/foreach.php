<?php

$numbers = [1, 2, 3, 4, 5];

foreach ($numbers as $number) {
    echo "$number ";
}

echo PHP_EOL;

// -------------------------------------------------------
$fruits = ["apple" => "яблоко", "banana" => "банан", "orange" => "апельсин"];

foreach ($fruits as $key => $value) {
    echo "Ключ: $key, Значение: $value\n";
}
