<?php

class Engine
{
    private $power;

    public function __construct(int $power)
    {
        $this->power = $power;
    }

    public function on()
    {
        // Реализация функционала
        // Много кода
        echo "Двигатель заведен".PHP_EOL;
    }
    public function off()
    {
        // Реализация функционала
        // Много кода
        echo "Двигатель выключен".PHP_EOL;
    }
}


class Car
{
    private $model;
    private $engine;

    public function __construct(string $model, Engine $engine)
    {
        $this->model = $model;
        $this->engine = $engine;
    }

    public function startEngine()
    {
        $this->engine->on();
    }

    public function stopEngine()
    {
        $this->engine->off();
    }
}

$engine = new Engine(160);
$myCar = new Car("Saturn VUE", $engine);

$myCar->startEngine();
$myCar->stopEngine();
