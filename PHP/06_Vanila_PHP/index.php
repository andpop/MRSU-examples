<?php
echo "<pre>";
echo '------ $_Server -------' . PHP_EOL;
print_r($_SERVER);

echo '------ $_GET -------' . PHP_EOL;
print_r($_GET);

echo '------ $_POST -------' . PHP_EOL;
print_r($_POST);

echo '------ Body -------' . PHP_EOL;
$body = file_get_contents("php://input");
echo $body . PHP_EOL;

echo "----------------";
echo date('Y-m-d');

echo "</pre>";
