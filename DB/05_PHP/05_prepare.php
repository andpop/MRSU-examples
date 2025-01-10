<?php

$db = new SQLite3('test.db');

$stm = $db->prepare('SELECT * FROM students WHERE lastname=?');
$stm->bindValue(1, 'Петров', SQLITE3_TEXT);

$result = $stm->execute();

while ($row = $result->fetchArray()) {
    echo "{$row['name']} {$row['lastname']} {$row['age']} \n";
}

$stm = $db->prepare('SELECT * FROM students WHERE age = :age');
$stm->bindValue(':age', 21, SQLITE3_INTEGER);

$result = $stm->execute();

while ($row = $result->fetchArray()) {
    echo "{$row['name']} {$row['lastname']} {$row['age']} \n";
}
