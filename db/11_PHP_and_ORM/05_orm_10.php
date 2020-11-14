<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

// ========= Many-to-One relations =================

$order = R::dispense('order');
$order->summa = 200;
$order->orderDate = '2020-05-10';
$order->customerId = 2005;
$order->vendor = R::load('vendor', 1002);

R::store($order);
