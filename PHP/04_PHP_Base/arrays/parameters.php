<?php
function processData($data) {
    if (isset($data->name)) {
        echo "Имя: " . $data->name . "\n";
    }

    if (isset($data->age) && is_numeric($data->age)) {
        echo "Возраст: " . $data->age . "\n";
    }

    if (isset($data->hobbies) && is_array($data->hobbies)) {
        echo "Хобби: " . implode(", ", $data->hobbies) . "\n";
    }

    if (isset($data->settings) && is_object($data->settings)) {
        echo "Настройки:\n";
        foreach ($data->settings as $key => $value) {
            echo "  $key: $value\n";
        }
    }
}

// Создаем объект с разнородными данными
$data = (object) [
    'name' => 'Jane Smith',
    'age' => 25,
    'hobbies' => ['painting', 'music'],
    'settings' => (object) [
        'theme' => 'light',
        'notifications' => false,
        'language' => 'fr'
    ]
];

// Вызываем функцию с передачей объекта
processData($data);
