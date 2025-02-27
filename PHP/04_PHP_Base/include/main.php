<?php

$a = 1;

echo "Hello from main.php\n";

/* f();  // Error, undefined func */

require_once("include.php");

f();   // Ok

echo "Bye from main.php\n";

