<?php
// =========== Подключение к БД ===================
define('MYSQL_USER', 'root');
define('MYSQL_PASSWORD', '12345678');    

try {
    $pdo = new PDO('mysql:host=localhost;dbname=test_db;charset=utf8', MYSQL_USER, MYSQL_PASSWORD);
} catch (PDOException $e) {
    exit('Ошибка при подключении к БД: '.$e->getMessage());
}


// ============= Простой запрос =======================

$query = "SELECT `name`, `city`, `percent` FROM `vendor`";
$statement = $pdo->query($query);

echo "Первая строка из результата запроса:\n";
$row = $statement->fetch(PDO::FETCH_ASSOC);
print_r($row);
$statement->closeCursor();

echo "-------------------------------------\n";

$query = "SELECT `name`, `city`, `percent` FROM `vendor`";
$statement = $pdo->query($query);
$rows = $statement->fetchAll();

echo "Перебор всех строк из результата запроса:\n";
foreach ($rows as $row) {
    echo $row['name'] . ' ' . $row['city'] . ' ' . $row['percent'] . "\n";
}
$statement->closeCursor();

echo "-------------------------------------\n";


// ============= Параметризованный запрос =======================
$query = "SELECT `name`, `city`, `percent` FROM `vendor` WHERE `id` = :vendor_id";
$statement = $pdo->prepare($query);

$vendor_id = 1001;

$statement->execute(['vendor_id' => $vendor_id]);
$row = $statement->fetch();
print_r($row);
$statement->closeCursor();

echo "-------------------------------------\n";

$vendor_id = 1002;
$statement->execute(['vendor_id' => $vendor_id]);
$row = $statement->fetch();
print_r($row);
$statement->closeCursor();

echo "-------------------------------------\n";

