<?php

$message = 'привет';

// Без конструкции use
$example = function () {
    var_dump($message);
};
$example();

// Наследуем переменную $message
$example = function () use ($message) {
    var_dump($message);
};
$example();

$example = fn() => var_dump($message);
$example();
