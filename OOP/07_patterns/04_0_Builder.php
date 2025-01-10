<?php

class Burger
{
    protected $size;

    protected $cheese = false;
    protected $pepperoni = false;
    protected $lettuce = false;
    protected $tomato = false;

    public function __construct($size, $isCheese, $isPepperoni, $isLettuce, $isTomato)
    {
        $this->size = $size;
        $this->cheese = $isCheese;
        $this->pepperoni = $isPepperoni;
        $this->lettuce = $isLettuce;
        $this->tomato = $isTomato;
    }
}


/////////////////////////////////////////////////////////////////////////////
// ===== Клиентский код ===================
/////////////////////////////////////////////////////////////////////////////

$burger = new Burger(14, true, false, true, false);

var_dump($burger);
