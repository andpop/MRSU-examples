<?php

function setup($x)
{
    $i = 0;
    return function () use ($x, &$i) {
        if (isset($x[$i])) {
            return $x[$i++];
        }

    };
}

$next = setup(['a', 'b', 'c']);
echo $next() . PHP_EOL;
echo $next() . PHP_EOL;
echo $next() . PHP_EOL;
echo $next() . PHP_EOL;
echo $next() . PHP_EOL;
echo '------------------';