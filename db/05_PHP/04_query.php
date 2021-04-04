<?php

$db = new SQLite3('test.db');

$result = $db->query('SELECT rowid, * FROM students');

while ($row = $result->fetchArray()) {
    echo "{$row['rowid']} {$row['name']} {$row['lastname']} {$row['age']} \n";
}

$lastName = 'Петров';
$sql = "SELECT * FROM students WHERE lastname='{$lastName}'";
echo $sql;
$result = $db->query($sql);

while ($row = $result->fetchArray()) {
    echo "{$row['name']} {$row['lastname']} {$row['age']} \n";
}