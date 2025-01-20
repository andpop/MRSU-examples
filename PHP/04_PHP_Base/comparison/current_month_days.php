<?php
$date = new DateTime();
$month = $date->format('M');

switch($month)
{
    case 'Jan':
    case 'Mar':
    case 'May':
    case 'Jul':
    case 'Aug':
    case 'Oct':
    case 'Dec':
        $day = 31;
        break;
    case 'Apr':
    case 'Jun':
    case 'Sep':
    case 'Nov':
        $day = 30;
        break;
    case 'Feb':
        $day = 28;
        break;
}
echo $day . PHP_EOL;

$result = match ($month) {
    'Jan', 'Mar', 'May', 'Jul', 'Aug', 'Oct', 'Dec' => 31,
    'Apr', 'Jun', 'Sep', 'Nov' => 30,
    'Feb' => 28
};
echo $result . PHP_EOL;
