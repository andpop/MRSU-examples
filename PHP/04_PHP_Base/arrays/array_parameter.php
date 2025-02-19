<?php
function processData(array $data) {
    // Обработка различных типов данных из массива
    if (isset($data['name'])) {
        echo "Имя: " . $data['name'] . "\n";
    }

    if (isset($data['age']) && is_numeric($data['age'])) {
        echo "Возраст: " . $data['age'] . "\n";
    }

    if (isset($data['hobbies']) && is_array($data['hobbies'])) {
        echo "Хобби: " . implode(", ", $data['hobbies']) . "\n";
    }

    if (isset($data['settings']) && is_array($data['settings'])) {
        echo "Настройки:\n";
        foreach ($data['settings'] as $key => $value) {
            echo "  $key: $value\n";
        }
    }
}

// Создаем массив с разнородными данными
$data = [
    'name' => 'John Doe',
    'age' => 30,
    'hobbies' => ['reading', 'traveling', 'programming'],
    'settings' => [
        'theme' => 'dark',
        'notifications' => true,
        'language' => 'en'
    ]
];

// Вызываем функцию с передачей массива
processData($data);
