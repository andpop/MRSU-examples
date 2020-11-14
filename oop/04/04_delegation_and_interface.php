<?php

namespace Popov\Lection4\Ex4;

interface EngineInterface
{
    public function on();
    public function off();
}

class Engine implements EngineInterface
{
    private $power;

    public function __construct(int $power)
    {
        $this->power = $power;
    }

    public function on()
    {
        // Реализация функционала
        echo "Двигатель заведен".PHP_EOL;
    }
    public function off()
    {
        // Реализация функционала
        echo "Двигатель выключен".PHP_EOL;
    }
}

class AnotherEngine implements EngineInterface
{
    private $power;

    public function __construct(int $power)
    {
        $this->power = $power;
    }

    public function on()
    {
        // Реализация функционала
        echo "Другой двигатель заведен".PHP_EOL;
    }
    public function off()
    {
        // Реализация функционала
        echo "Другой двигатель выключен".PHP_EOL;
    }
}


class Car
{
    private $model;
    private $engine;

    public function __construct(string $model, EngineInterface $engine)
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

$engine2 = new AnotherEngine(200);
$myCar2 = new Car("BMW X5", $engine2);

$myCar2->startEngine();
$myCar2->stopEngine();
