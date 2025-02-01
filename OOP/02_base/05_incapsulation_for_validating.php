<?php
class Car
{
    private $acceptableColors = ["белый", "черный", "красный"];
    private $color;

    public function __construct()
    {
        $this->color = $this->acceptableColors[0];
    }

    public function paint($color)
    {
        if (in_array($color, $this->acceptableColors)) {
            $this->color = $color;
        } else {
            throw new \Exception("В $color цвет не красим!");
        }
    }

    public function displayColor()
    {
        echo "Цвет машины: $this->color".PHP_EOL;
    }
}


$car1 = new Car;

$car1->displayColor();
try {
    $car1->paint("красный");
} catch (Exception $e) {
    echo $e->getMessage().PHP_EOL;
}

$car1->displayColor();
