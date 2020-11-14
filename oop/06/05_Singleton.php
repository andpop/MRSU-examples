<?php

final class President
{
    private static $instance;

    private function __construct()
    {
        // Прячем конструктор
    }

    private function __clone()
    {
        // Отключаем клонирование
    }

    private function __wakeup()
    {
        // Отключаем десериализацию
    }

    public static function getInstance(): President
    {
        if (!self::$instance) {
            self::$instance = new self();
        }

        return self::$instance;
    }

}

$president1 = President::getInstance();
$president2 = President::getInstance();

var_dump($president1 === $president2); // true
