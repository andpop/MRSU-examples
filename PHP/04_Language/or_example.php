<?php

$content = file_get_contents('example.txt') or exit('Ошибка');
var_dump($content);

$content = file_get_contents('example.txt') || exit('Ошибка');
var_dump($content);
