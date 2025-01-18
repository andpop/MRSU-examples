<?php
declare(strict_types = 1);

function convert (int $value, int $factor = 1_000) : int
{
    return $value * $factor;
}

echo convert(11, 1024) . PHP_EOL; // 11264

// Будет ошибка несовпадения типов
echo convert('10.0', 1024.0); // 10240

