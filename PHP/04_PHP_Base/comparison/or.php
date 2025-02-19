<?php

$content = file_get_contents('example.txt') or exit('Ошибка');
var_dump($content); // $content содержит содержимое файла example.txt

/* $content = (file_get_contents('example.txt') || exit('Ошибка')); */
$content = file_get_contents('example.txt') || exit('Ошибка');
var_dump($content); // bool(true)

($content = file_get_contents('example.txt')) || exit('Ошибка');
var_dump($content); // Содержимое файла example.txt
