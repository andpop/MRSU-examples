<?php

function getLines($file)
{
    $f = fopen($file, 'r');
    if (!$f) {
        throw new Exception();
    }
    while ($line = fgets($f)) {
        yield $line;
    }
    fclose($f);
}

foreach (getLines('data.txt') as $line) {
    echo $line;
}
