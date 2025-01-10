<?php
// =========== Подключение к БД ===================
define('MYSQL_SERVER', 'localhost');     
define('MYSQL_USER', 'root');
define('MYSQL_PASSWORD', '12345678');    
define('MYSQL_DB', 'test_db');

$mysqli = new mysqli(MYSQL_SERVER, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DB);

if ($mysqli->connect_errno) {
    exit("Ошибка при подключении к БД: ".$mysqli->connect_error);
}

if (!$mysqli->set_charset("utf8")){
    printf("Error: ".$mysqli->error);
}


// ============= Простой запрос =======================

$query = "SELECT `name`, `city`, `percent` FROM vendor";
$result_set = $mysqli->query($query);

echo "Первая строка из результата запроса:\n";
$row = $result_set->fetch_assoc();
print_r($row);
$result_set->close();

echo "-------------------------------------\n";

$query = "SELECT `name`, `city`, `percent` FROM vendor";
$result_set = $mysqli->query($query);
echo "Перебор всех строк из результата запроса:\n";
while ($row = $result_set->fetch_assoc()) {
    echo $row['name'] . ' ' . $row['city'] . ' ' . $row['percent'] . "\n";
}
$result_set->close();

echo "-------------------------------------\n";

$query = "SELECT `name`, `city`, `percent` FROM vendor";
$result_set = $mysqli->query($query);
echo "Перебор всех строк из результата запроса:\n";
while ($row = $result_set->fetch_object()) {
    echo $row->name . ' ' . $row->city . ' ' . $row->percent . "\n";
}
$result_set->close();
