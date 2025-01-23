<?php
class Car
{
    private string $manufacturer;
    private string $model;
    private string $color;
    private int $year;

    public function __construct(string $manufacturer, string $model, string $color, int $year = 2019)
    {
        $this->manufacturer = $manufacturer;
        $this->model = $model;
        $this->color = $color;
        $this->year = $year;
    }

    public function displayColor()
    {
        echo "Цвет: $this->color".PHP_EOL;
        echo '$this in displayColor: ' . get_class($this) . PHP_EOL;
    }
}

class PassengerCar extends Car
{
    private int $numberPassenger;

    public function setNumberPassenger(int $numberPassenger)
    {
        $this->numberPassenger = $numberPassenger;
    }

    public function displayNumberPassenger()
    {
        echo "Количество мест: $this->numberPassenger".PHP_EOL;
        echo '$this in displayNumberPassenger: ' . get_class($this) . PHP_EOL;
    }
}

$car1 = new PassengerCar("Lada", "Granta", "синий");
$car1->setNumberPassenger(5);

if ($car1 instanceof PassengerCar) {
    echo 'instance of PassengerCar' . PHP_EOL;
}


if ($car1 instanceof Car) {
    echo 'instance of Car' . PHP_EOL;
}

echo get_class($car1) . PHP_EOL;

// Метод определен в PassengerCar
$car1->displayNumberPassenger();

// Метод определен в Car
$car1->displayColor();

