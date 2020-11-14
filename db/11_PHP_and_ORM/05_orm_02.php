<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

//Insert row
$user = R::dispense('user');

$user->name = 'Петр';
$user->last_name = 'Иванов';
$user->age = 43;
$user->country = 'Россия';


R::store($user);
