<?php
namespace Popov\Lection2\Ex7;

class Car
{
    private $manufacturer;
    protected $model;
    private $color;
    private $year;

    public function __construct($manufacturer, $model, $color, $year = 2019)
    {
        $this->manufacturer = $manufacturer;
        $this->model = $model;
        $this->color = $color;
        $this->year = $year;
    }

    public function displayColor()
    {
        echo "Цвет: $this->color".PHP_EOL;
    }
}

class PassengerCar extends Car
{
    private $numberPassenger;

    public function setNumberPassenger($numberPassenger)
    {
        $this->numberPassenger = $numberPassenger;
    }

    public function __construct($manufacturer, $model, $color, $year, $numberPassenger)
    {
        parent::__construct($manufacturer, $model, $color, $year);
        $this->numberPassenger = $numberPassenger;
        echo $this->model.PHP_EOL;
    }

    public function displayNumberPassenger()
    {
        echo "Количество мест: $this->numberPassenger".PHP_EOL;
    }
}

$car1 = new PassengerCar("Lada", "Granta", "синий", 2018, 5);

// Метод определен в PassengerCar
$car1->displayNumberPassenger();

// Метод определен в Car
$car1->displayColor();



