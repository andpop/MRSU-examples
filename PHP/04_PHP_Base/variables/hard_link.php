<?php

$a = 1;
$b = &$a;
echo "b = $b\n";

$b = 2;
echo "a = $a\n";

unset($a);
echo "b = $b\n";
