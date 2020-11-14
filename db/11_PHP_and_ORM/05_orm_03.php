<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

// FREEZE
R::freeze(true);

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

//Insert row
$user = R::dispense('user');

$user->name = 'Маша';
$user->last_name = 'Иванова';
$user->age = 18;
$user->country = 'Россия';
$user->phone = '12345678';


R::store($user);
