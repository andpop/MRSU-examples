<?php
$date = new DateTime();

// Выведет текущую дату и время 
// в формате ГГГГ-ММ-ДД ЧЧ:ММ:СС
echo $date->format('Y-m-d H:i:s'); 

echo gettype($date) . PHP_EOL; // object
echo get_class($date) . PHP_EOL; // DateTime
echo $date::class . PHP_EOL;     // DateTime

$reflection = new ReflectionClass('DateTime');

// Получаем все свойства класса
$properties = $reflection->getProperties();
foreach ($properties as $property) {
    echo "Имя свойства: " . $property->getName() . "\n";
}

// Получаем все методы класса
$methods = $reflection->getMethods();
foreach ($methods as $method) {
    echo "Имя метода: " . $method->getName() . "\n";
}
