<?php

$arr = [];
$arr[] = 1;
$arr[] = 2;
print_r($arr);

[$a1, $a2] = $arr;
echo "a1=$a1 a2=$a2" . PHP_EOL;

// -----------------------------------------------------------------
$person = ['first' => 'Rasmus', 'last' => 'Lerdorf', 'manager' => true];

['last' => $lastname, 'first' => $firstname] = $person;
echo "lastname=$lastname firstname=$firstname" . PHP_EOL;
