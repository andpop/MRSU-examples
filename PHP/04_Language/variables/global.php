<?php

$a = 1;

function f2()
{
    global $a;
    echo "a = ${a}\n";
}

f2();
