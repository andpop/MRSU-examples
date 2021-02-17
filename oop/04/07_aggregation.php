<?php

class Engine
{
    private $power;

    public function __construct(int $power)
    {
        $this->power = $power;
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
}

$engine = new Engine(100);
$myCar = new Car("Saturn VUE", $engine);

var_dump($myCar);
