<?php

$db = new SQLite3('test.db');

$db->exec("create table students (name, lastname, age)");
$db->exec("insert into students(name, lastname, age) values ('Иван', 'Петров', 20)");
$db->exec("insert into students(name, lastname, age) values ('Анна', 'Иванова', 21)");

$last_row_id = $db->lastInsertRowID();
echo "The last inserted row Id is $last_row_id";
