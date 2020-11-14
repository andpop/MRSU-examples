<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

$vendor = R::load('vendor', 1001);
print_r($vendor);

echo "{$vendor->name} {$vendor['city']}\n";

$vendor = $vendor->export();
print_r($vendor);
