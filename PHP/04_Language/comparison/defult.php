<?php

$animal = 'крокодил';
$sound = match ($animal) {
    'кошка' => 'мяу',
    'собака' => 'гав',
    'корова' => 'му',
    default => 'Неизвестный звук!'
};
echo $sound; // Неизвестный звук!
