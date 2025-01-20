<?php
namespace Example;

function strlen($str)
{
    echo 'Функция Example\strlen' . PHP_EOL;
    return count(str_split($str));
}

echo strlen('Hello') . PHP_EOL;
echo '-------------------------------------' . PHP_EOL;
echo \strlen('Hello') . PHP_EOL;
echo '-------------------------------------' . PHP_EOL;
echo namespace\strlen('Hello') . PHP_EOL;

