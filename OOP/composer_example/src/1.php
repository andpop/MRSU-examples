<?php
$loadPath1 = __DIR__ . '/../../../autoload.php';
$loadPath2 = __DIR__ . '/../vendor/autoload.php';

if (file_exists($loadPath1)) {
    include_once $loadPath1;
} else {
    include_once $loadPath2;
}

use function cli\line;
line("Hello!");
line("Goodbye!");

//\cli\line("dafdfd");
