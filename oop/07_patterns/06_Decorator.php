<?php

interface Coffee
{
    public function getCost();
    public function getDescription();
}

//Базовый класс
class SimpleCoffee implements Coffee
{
    public function getCost()
    {
        return 10;
    }

    public function getDescription()
    {
        return 'Simple coffee';
    }
}

// =========== Декораторы =====================================================
// Декоратор
class MilkCoffee implements Coffee
{
    protected $coffee;

    public function __construct(Coffee $coffee)
    {
        $this->coffee = $coffee;
    }

    public function getCost()
    {
        return $this->coffee->getCost() + 2;
    }

    public function getDescription()
    {
        return $this->coffee->getDescription() . ', milk';
    }
}

// Декоратор
class WhipCoffee implements Coffee
{
    protected $coffee;

    public function __construct(Coffee $coffee)
    {
        $this->coffee = $coffee;
    }

    public function getCost()
    {
        return $this->coffee->getCost() + 5;
    }

    public function getDescription()
    {
        return $this->coffee->getDescription() . ', whip';
    }
}

// Декоратор
class VanillaCoffee implements Coffee
{
    protected $coffee;

    public function __construct(Coffee $coffee)
    {
        $this->coffee = $coffee;
    }

    public function getCost()
    {
        return $this->coffee->getCost() + 3;
    }

    public function getDescription()
    {
        return $this->coffee->getDescription() . ', vanilla';
    }
}


/////////////////////////////////////////////////////////////////////////////
// ===== Клиентский код ===================
/////////////////////////////////////////////////////////////////////////////

// Готовим кофе
$coffee = new SimpleCoffee();
echo $coffee->getDescription() . PHP_EOL; // Simple Coffee
echo $coffee->getCost() . PHP_EOL; // 10
echo "----------------------------------------------\n";

// Simple Coffee + milk
$coffee = new MilkCoffee($coffee);
echo $coffee->getDescription() . PHP_EOL;
echo $coffee->getCost() . PHP_EOL; // 12
echo "----------------------------------------------\n";

// Simple Coffee + milk + whip
$coffee = new WhipCoffee($coffee);
echo $coffee->getDescription() . PHP_EOL;
echo $coffee->getCost() . PHP_EOL; // 17
echo "----------------------------------------------\n";

// Simple Coffee + milk + whip + vanilla
$coffee = new VanillaCoffee($coffee);
echo $coffee->getDescription() . PHP_EOL;
echo $coffee->getCost() . PHP_EOL; // 20

echo "====================================================\n";

$coffee = new VanillaCoffee(new WhipCoffee(new MilkCoffee(new SimpleCoffee())));
echo $coffee->getDescription() . PHP_EOL;
echo $coffee->getCost() . PHP_EOL;
