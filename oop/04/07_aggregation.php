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

$myCar = new Car("Saturn VUE", new Engine(160));

var_dump($myCar);
