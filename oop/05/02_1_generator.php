<?php

function numbers()
{
    echo "START" . PHP_EOL;
    for ($i = 0; $i < 5; ++$i) {
        yield $i;
    }
    echo "FINISH" . PHP_EOL;
}

$x = numbers();
var_dump($x);

/* foreach ($x as $value) { */
/*     echo "VALUE: $value" . PHP_EOL; */
/* } */
