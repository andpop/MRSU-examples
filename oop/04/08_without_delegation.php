<?php

class Car
{
    private $model;

    public function __construct(string $model)
    {
        $this->model = $model;
    }

    public function startEngine()
    {
        // Реализация функционала
        // Много кода
        echo "Двигатель заведен".PHP_EOL;
    }

    public function stopEngine()
    {
        // Реализация функционала
        // Много кода
        echo "Двигатель выключен".PHP_EOL;
    }
}

$myCar = new Car("Saturn VUE");

$myCar->startEngine();
$myCar->stopEngine();
