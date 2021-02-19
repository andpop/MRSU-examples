<?php

class Bird
{
    public function fly() {
        $flySpeed = 10;
        return $flySpeed;
    }
}

class Duck extends Bird // Дополняет поведение, не изменяя его
{
    
    public function fly() {
        $flySpeed = 8;
        return $flySpeed;
    }
    
    public function swim() {
        $swimSpeed = 2;
        return $swimSpeed;
    }
}

class Penguin extends Bird // Меняет поведение - нарушение LSP
{

    public function fly() {
        return 'I can\'t fly!'; // нетипичное поведение
    }

    // возможное решение для соблюдение принципа LSP
    //    public function fly() {
    //        $flySpeed = 0;
    //        return $flySpeed;
    //    }

    public function swim() {
        $swimSpeed = 6;
        return $swimSpeed;
    }
}

class BirdRun
{
    
    private $bird;
    
    public function __construct(Bird $bird) {
        $this->bird = $bird;
    }
    
    public function run() {
        $flySpeed = $this->bird->fly();
        echo "Летим со скорость $flySpeed км/ч";
        // ...
    }
}


$bird = new Bird();
// $bird = new Duck();
//$bird = new Penguin();

$birdRun = new BirdRun($bird);
$birdRun->run();
