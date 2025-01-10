<h2>Hello from index.php</h2>
<?php
echo "<pre>";
echo '------ $_Server -------' . PHP_EOL;
print_r($_SERVER);

echo '------ $_GET -------' . PHP_EOL;
print_r($_GET);

echo '------ $_POST -------' . PHP_EOL;
print_r($_POST);

echo "----------------";
echo date('Y-m-d');

echo "</pre>";
