<?php

//Интерфейс двери
interface Door
{
    public function getWidth(): float;
    public function getHeight(): float;
}

//Реализация интерфейса двери
class WoodenDoor implements Door
{
    protected $width;
    protected $height;

    public function __construct(float $width, float $height)
    {
        $this->width = $width;
        $this->height = $height;
    }

    public function getWidth(): float
    {
        return $this->width;
    }

    public function getHeight(): float
    {
        return $this->height;
    }
}

class IronDoor implements Door
{
    protected $width;
    protected $height;

    public function __construct(float $width, float $height)
    {
        $this->width = $width;
        $this->height = $height;
        echo 'Новая железная дверь'.PHP_EOL;
    }

    public function getWidth(): float
    {
        return $this->width;
    }

    public function getHeight(): float
    {
        return $this->height;
    }
}

//Фабрика дверей
class DoorFactory
{
    private $door;
    public function makeDoor($doorType, $width, $height): Door
    {
        switch ($doorType) {
            case 'wooden':
                $this->door = new WoodenDoor($width, $height);
                break;
            case 'iron':
                $this->door = new IronDoor($width, $height);
                break;
        }

        return $this->door;
    }
}


/////////////////////////////////////////////////////////////////////////////
// ===== Клиентский код ===================
/////////////////////////////////////////////////////////////////////////////

$doorType = 'iron';

//Использование фабрики
$factory = new DoorFactory();
$door = $factory->makeDoor($doorType, 100, 200);

echo 'Width: ' . $door->getWidth() . PHP_EOL;
echo 'Height: ' . $door->getHeight() . PHP_EOL;
