<?php

function numbers()
{
    echo "START" . PHP_EOL;
    for ($i = 0; $i < 5; ++$i) {
        yield $i;
        echo "VALUE: $i" . PHP_EOL;
    }
    echo "FINISH" . PHP_EOL;
}

foreach (numbers() as $value) {
};
