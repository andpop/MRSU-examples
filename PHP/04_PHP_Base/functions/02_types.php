<?php

function convert (int $value, int $factor = 1_000) : int
{
    return $value * $factor;
}

// Фактические параметры преобразуются к указанным типам аргументов
echo convert(11, 1024) . PHP_EOL; // 11264
echo convert('10.0', 1024.0); // 10240

