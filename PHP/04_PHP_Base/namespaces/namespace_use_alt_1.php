<?php
require_once 'namespace_alt.php';

use Example\constants as cons;
use Example\functions;

echo 'Версия ' . cons\VERSION . PHP_EOL;
functions\debug([1, 2, 3]);
