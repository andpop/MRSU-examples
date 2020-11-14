<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

$vendors = R::loadAll('vendor', [1001, 1002, 1003]);
//print_r($users);

foreach ($vendors as $vendor) {
    echo $vendor->name . PHP_EOL;
}
