<?php

namespace Popov\Lection4\Ex1;

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

    public function __construct(string $model, int $power)
    {
        $this->model = $model;
        $this->engine = new Engine($power);
    }
}

$myCar = new Car("Saturn VUE", 160);

var_dump($myCar);