<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

// ========= One-to-Many relations with conditions =================

// Get child rows
$vendor = R::load('vendor', 1001);

$orders = $vendor->with('ORDER BY `order_date`')->ownOrderList;

foreach ($orders as $order) {
    echo "{$vendor->name} {$order->order_date} {$order->summa}\n";
}

echo "--------------------------------------------\n";

$orders = $vendor->withCondition('`summa` < 130 ORDER BY `order_date`')->ownOrderList;

foreach ($orders as $order) {
    echo "{$vendor->name} {$order->order_date} {$order->summa}\n";
}
