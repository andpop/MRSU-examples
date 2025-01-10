<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

// Find row
$vendors = R::find('vendor', '`city` = ?', ['Саранск']);

foreach ($vendors as $vendor) {
    echo $vendor->name . PHP_EOL;
}

// Find or create row
$vendor = R::findOrCreate('vendor', [
    'name' => 'Козлов',
    'city' => 'Саранск',
    'percent' => 25
]);

// Count rows
echo 'Всего продавцов: ' . R::count('vendor') . PHP_EOL;

// Batch update
$vendors = R::findAll('vendor');
foreach ($vendors as $vendor) {
    $vendor->percent = $vendor->percent + 1;
}
R::storeAll($vendors);