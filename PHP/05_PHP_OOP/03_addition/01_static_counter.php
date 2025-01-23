<?php
class Counter {
    public static $count = 0; // Статическое свойство

    public function increment() {
        self::$count++; // Увеличиваем счётчик
    }

    public static function getCount() {
        return self::$count; // Возвращаем текущее значение счётчика
    }
}

Counter::$count = 100; // Устанавливаем начальное значение счётчика

$counter1 = new Counter();
$counter1->increment(); // Увеличили счётчик до 101

$counter2 = new Counter();
$counter2->increment(); // Увеличили счётчик до 102

echo Counter::getCount(); // Выведем 102
