<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

// ========= One-to-Many relations =================

// Get child rows
$vendor = R::load('vendor', 1001);

$orders = $vendor->ownOrderList;
// SELECT `vendor`.*  FROM `vendor`  WHERE ( `id` IN ( 1001 ) )
// SELECT `order`.*  FROM `order`  WHERE vendor_id = 1001

// print_r($orders);

foreach ($orders as $order) {
    echo "{$vendor->name} {$order->order_date} {$order->summa}\n";
}


// Add child row
$order = R::dispense('order');
$order->summa = 100;
$order->orderDate = '2020-05-16';
$order->customerId = 2005;

$vendor->ownOrderList[] = $order;
R::store($vendor);

$lastOrderId = R::getInsertID();
echo $lastOrderId."\n";
R::trash($vendor->ownOrderList[$lastOrderId]);