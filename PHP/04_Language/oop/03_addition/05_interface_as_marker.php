<?php

namespace Popov\Lection3\Ex5;

abstract class Food
{
    public $description;
    public $calories;
}

class Meat extends Food
{
    public function __construct()
    {
        $this->description = "Мясо";
    }
}

class Milk extends Food
{
    public function __construct()
    {
        $this->description = "Молоко";
    }
}

class Potato extends Food
{
    public function __construct()
    {
        $this->description = "Картошка";
    }
}

class Onion extends Food
{
    public function __construct()
    {
        $this->description = "Лук";
    }
}


abstract class Eater
{
    public $name;
    protected $type;

    protected function canEat(Food $food)
    {
        return true;
    }

    public function eat(Food $food)
    {
        echo "Меня зовут " . $this->name . ". Я " . $this->type . "." . PHP_EOL;
        if ($this->canEat($food)) {
            echo "Я ем " . $food->description . PHP_EOL;
        } else {
            echo $food->description . " я не ем!" . PHP_EOL;
        }

    }
}

class MeatEater extends Eater
{
    public function __construct($name)
    {
        $this->type = "мясоед";
        $this->name = $name;
    }
}

class Vegan extends Eater
{
    public function __construct($name)
    {
        $this->type = "вегатарианец";
        $this->name = $name;
    }

    protected function canEat(Food $food)
    {
        return false;
    }
}

$meatEater = new MeatEater("Ваня");
$vegan = new Vegan("Петя");

$meatEater->eat(new Meat());
$meatEater->eat(new Milk());

$vegan->eat(new Milk);
$vegan->eat(new Potato);
$vegan->eat(new Onion);
