<?php
require_once('./03_functions.php');

$mysqli = db_connect();
$mysqli->set_charset("utf8");

$query = "SELECT `name` FROM vendor WHERE `id` =  1001";
$name = getCell($query);
echo $name . "\n";

echo "-------------------------------------\n";

$query = "SELECT `name`, `city`, `percent` FROM vendor WHERE `id` =  1001";
$vendor = getRow($query);
print_r($vendor);

echo "-------------------------------------\n";

$query = "SELECT `name`, `city`, `percent` FROM vendor";
$vendors = getTable($query);
echo $vendors[1]['name'] . ' ' . $vendors[1]['city'] . "\n";
echo $vendors[2]['name'] . ' ' . $vendors[2]['city'] . "\n";

echo "-------------------------------------\n";

$vendor = [];
$vendor['name'] = 'Зингельшухер';
$vendor['city'] = 'Саранск';
$vendor['percent'] = 25;
$new_id = addRow('vendor', $vendor);

$query = "SELECT `name`, `city`, `percent` FROM vendor WHERE `id` = {$new_id}";
$vendor = getRow($query);
print_r($vendor);

echo "-------------------------------------\n";

$vendor['name'] = 'Пушкин';
$vendor['city'] = 'Саранск';
$vendor['percent'] = 20;
setRow('vendor', $new_id, $vendor);

$query = "SELECT `name`, `city`, `percent` FROM vendor WHERE `id` = {$new_id}";
$vendor = getRow($query);
print_r($vendor);

echo "-------------------------------------\n";

deleteRow('vendor', $new_id);
