<?php
class User {
    private $name;

    public function __construct($name) {
        $this->name = $name;
    }

    // Магический метод __toString()
    public function __toString() {
        return "Пользователь: {$this->name}";
    }

    public function __invoke($arg) {
        echo "Привет, $arg!";
    }
}

// Создаем экземпляр класса User
$user = new User("Иван");

// Выводим объект как строку
echo $user . PHP_EOL;  // Выведет: Пользователь: Иван

$user("Иван"); // Выведет: Привет, Иван
