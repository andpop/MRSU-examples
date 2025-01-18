<?php

function cube(int|float $n): int|float
{
    return $n * $n * $n;
}

$arr = [1, 2, 3, 4, 5];

// Callback с обычной функцией
$cub1 = array_map('cube', $arr);
print_r($cub1);

// Callback с анонимной функцией
$cub2 = array_map(function (int|float $n): int|float {
    return $n * $n * $n;
}, $arr);
print_r($cub2);

// Callback со стрелочной функцией
$cub3 = array_map(fn(int|float $n): int|float => $n * $n * $n, $arr);
print_r($cub3);
