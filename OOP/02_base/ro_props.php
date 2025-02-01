<?php

class User {
    public readonly string $name;
    public readonly int $age;

    public function __construct(string $name, int $age) {
        $this->name = $name;
        $this->age = $age;
    }

    public function getName(): string {
        return $this->name;
    }

    public function getAge(): int {
        return $this->age;
    }
}

$user = new User('John Doe', 30);
echo $user->getName() . PHP_EOL; // Выведет "John Doe"
echo $user->getAge() . PHP_EOL;  // Выведет 30

echo $user->name . PHP_EOL; // Выведет "John Doe"
// Попробуем изменить значение свойства age
$user->age = 35; // Ошибка времени выполнения: Cannot modify readonly property User::$age
