<?php
abstract class Animal
{
    abstract public function speak();
}

class Cat extends Animal
{
    public function speak()
    {
        echo "Мяу!!!!".PHP_EOL;
    }
}

class Dog extends Animal
{
    public function speak()
    {
        echo "Гав-гав!!!!".PHP_EOL;
    }
}

class Duck extends Animal
{
    public function speak()
    {
        echo "Кря-кря!!!!".PHP_EOL;
    }
}

class Frog extends Animal
{
    public function speak()
    {
        echo "Ква!" .PHP_EOL;
    }
}

class Cow extends Animal
{
   public function speak()
   {
       echo "Муууу!" .PHP_EOL;
   }
}

function speak(Animal $animal)
{
    $animal->speak();
}

$cat = new Cat;
$dog = new Dog;
$duck = new Duck;
$frog = new Frog();
$burenka = new Cow();

speak($cat);
speak($dog);
speak($duck);
speak($frog);
speak($burenka);
