<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

//CREATE
$user = R::dispense('user');

$user->name = 'Иван';
$user->last_name = 'Петров';
$user->age = 34;

R::store($user);
