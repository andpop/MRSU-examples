<?php
// =========== Подключение к БД ===================
define('MYSQL_USER', 'root');
define('MYSQL_PASSWORD', '12345678');    

try {
    $pdo = new PDO('mysql:host=localhost;dbname=test_db;charset=utf8', MYSQL_USER, MYSQL_PASSWORD);
} catch (PDOException $e) {
    exit('Ошибка при подключении к БД: '.$e->getMessage());
}


// ============= Непараметризованный запрос =======================
echo "Непараметризованный запрос с SQL-инъекцией:\n";
$vendor_id = "1001 OR 1=1";
// $vendor_id = "1001;DELETE FROM `vendor` WHERE `id` = 1010";

$query = "SELECT `name`, `city`, `percent` FROM `vendor` WHERE `id` = $vendor_id";

$statement = $pdo->query($query);
$rows = $statement->fetchAll();

echo "Перебор всех строк из результата запроса:\n";
foreach ($rows as $row) {
    echo $row['name'] . ' ' . $row['city'] . ' ' . $row['percent'] . "\n";
}
$statement->closeCursor();

echo "-------------------------------------\n";


// ============= Параметризованный запрос =======================
echo "Параметризованный запрос с SQL-инъекцией:\n";

$vendor_id = "1001 OR 1=1";

$query = "SELECT `name`, `city`, `percent` FROM `vendor` WHERE `id` = :vendor_id";
$statement = $pdo->prepare($query);
$statement->execute(['vendor_id' => $vendor_id]);
$rows = $statement->fetchAll();

echo "Перебор всех строк из результата запроса:\n";
foreach ($rows as $row) {
    echo $row['name'] . ' ' . $row['city'] . ' ' . $row['percent'] . "\n";
}
$statement->closeCursor();

echo "-------------------------------------\n";
