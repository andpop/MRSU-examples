<?php

$a = 1;

function f()
{
    global $a;
    echo "1. a = $a\n";
    $a  = 123;

    unset($a);
    echo "2. a = $a\n";
}

f();

echo "3. a = $a\n";
