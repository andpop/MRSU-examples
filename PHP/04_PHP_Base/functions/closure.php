<?php

$message = 'привет';

// Без конструкции use
$example = function () {
    var_dump($message);
};
$example();

// Захватываем переменную $message
$example = function () use ($message) {
    var_dump($message);
};
$example();

// Для стрелочной функции use() не нужен
$example = fn() => var_dump($message);
$example();
