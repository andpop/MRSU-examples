<?php
require './RedBeanPHP5_5-mysql/rb-mysql.php';

R::setup('mysql:host=localhost;dbname=test_db', 'root', '12345678');
R::useFeatureSet( 'novice/latest' );

if (!R::testConnection()) {
    die('Не удалось подключиться к БД.');
}

//Delete row
$vendor = R::load('vendor', 1013);

R::trash($vendor);

//Полная очистка таблицы (TRUNCATE)
//R::wipe('vendor');

//Полная очистка всей базы данных
//R::nuke();