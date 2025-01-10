<?php

$pdo = new PDO('sqlite:test.db');

// ============= Простой запрос =======================

$query = "SELECT * FROM students";
$statement = $pdo->query($query);

echo "Первая строка из результата запроса:\n";
$row = $statement->fetch(PDO::FETCH_ASSOC);
print_r($row);
$statement->closeCursor();

echo "-------------------------------------\n";

$query = "SELECT rowid, name, lastname FROM students";
$statement = $pdo->query($query);
$rows = $statement->fetchAll();

echo "Перебор всех строк из результата запроса:\n";
foreach ($rows as $row) {
    echo $row['rowid'] . ' ' . $row['name'] . ' ' . $row['lastname'] . "\n";
}
$statement->closeCursor();

echo "-------------------------------------\n";


// ============= Параметризованный запрос =======================
$query = "SELECT `name`, `lastname`, `age` FROM `students` WHERE `rowid` = :id";
$statement = $pdo->prepare($query);

$id = 3;

$statement->execute(['id' => $id]);
$row = $statement->fetch();
print_r($row);
$statement->closeCursor();

echo "-------------------------------------\n";

$id = 2;
$statement->execute(['id' => $id]);
$row = $statement->fetch();
print_r($row);
$statement->closeCursor();

echo "-------------------------------------\n";
