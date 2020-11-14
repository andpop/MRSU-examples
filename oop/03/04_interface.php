<?php

namespace Popov\Lection3\Ex4;

interface ElectricalPlug
{
    public function plug();
    public function unPlug();
}

abstract class Plug
{
    public $numberContacts;
}

class SimplePlug extends Plug implements ElectricalPlug
{
    public function plug()
    {
        echo "Простая вилка вставлена в розетку" . PHP_EOL;
    }
    public function unPlug()
    {
        echo "Простая вилка вынута из розетки" . PHP_EOL;
    }

    public function __construct()
    {
        $this->numberContacts = 2;
    }
}

class GroundedPlug extends SimplePlug implements ElectricalPlug
{
    public function plug()
    {
        echo "Вилка с заземлением вставлена в розетку" . PHP_EOL;
    }
    public function unPlug()
    {
        echo "Вилка с заземлением вынута из розетки" . PHP_EOL;
    }

    public function __construct()
    {
        $this->numberContacts = 3;
    }

}


abstract class ElectricalDevice
{
    protected $plug;

    public function on()
    {
        $this->plug->plug();
    }

    public function off()
    {
        $this->plug->unPlug();
    }
}

class Iron extends ElectricalDevice
{
    public function __construct()
    {
        $this->plug = new SimplePlug();
    }

}

class TV extends ElectricalDevice
{
    public function __construct()
    {
        $this->plug = new GroundedPlug();
    }
}


$iron = new Iron();
$tv = new TV();

$iron->on();
$tv->on();

$iron->off();
$tv->off();
