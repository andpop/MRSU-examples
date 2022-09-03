<?php

use Andrv\Test\Point;

require_once __DIR__ . "/vendor/autoload.php";
use function cli\line;

echo "Привет!!!" . PHP_EOL;
echo "Пока!!!" . PHP_EOL;

line("Hello from CLI!!!");

Andrv\Test\Functions\hello("Andrey");

$point = new Point();
$point->x = 1;
line($point->x);
