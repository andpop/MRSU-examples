<?php
$date = new DateTime();

echo gettype($date) . PHP_EOL; // object
echo get_class($date) . PHP_EOL; // DateTime
echo $date::class . PHP_EOL;     // DateTime
