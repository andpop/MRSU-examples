<?php

function numbers()
{
    echo "START" . PHP_EOL;
    for ($i = 0; $i < 5; ++$i) {
        yield $i;
    }
    echo "FINISH" . PHP_EOL;
}

$ranges = numbers();
var_dump($ranges);

$n = $ranges->current();
echo "$n\n";

$ranges->next();
$n = $ranges->current();
echo "$n\n";

/* foreach ($ranges as $value) { */
/*     echo "VALUE: $value" . PHP_EOL; */
/* } */
