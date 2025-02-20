<?php

$a = 1;

function f()
{
    $a = &$GLOBALS['a'];
    echo "1. a = $a\n";
    $a = 123;

    unset($a);
    echo "2. a = $a\n";
}

function f2()
{
    echo "1. a = {$GLOBALS['a']}\n";
    unset($GLOBALS['a']);
}

f2();
/* f(); */

echo "3. a = $a\n";
