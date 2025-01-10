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
        echo 'Новая деревянная дверь'.PHP_EOL;
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

/////////////////////////////////////////////////////////////////////////////
//Основная программа
/////////////////////////////////////////////////////////////////////////////
$doorType = 'iron';

switch ($doorType) {
  case 'wooden':
    $door = new WoodenDoor(20, 30);
    break;
  case 'iron':
    $door = new IronDoor(20, 30);
    break;
}

// var_dump($woodenDoor);
// var_dump($ironDoor);