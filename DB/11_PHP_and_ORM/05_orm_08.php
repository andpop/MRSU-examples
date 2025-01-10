<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

$orders = R::getAll('SELECT b.name, a.order_date, a.summa FROM `order` a, `vendor` b WHERE a.vendor_id = b.id');

foreach ($orders as $order) {
    echo $order['name'].' '.$order['order_date'].' '.$order['summa']."\n";
}
