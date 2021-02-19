<?php

interface FoodProvider {
    public function getFood();
}

class Wife implements IFoodProvider
{
    public function getFood() {
        // ...
        return $food;
    }
}

class Restaurant implements IFoodProvider
{
    public function getFood() {
        //...
        return $food;
    }
}

// ==============================================================================

class Male1
{
    public function eat()
    {
        $wife = new Wife();
        $food = $wife->getFood();
        // ...eat
    }
}

// ==============================================================================

class Male2  // Dependency injection
{
    private $wife;

    public function __construct(Wife $wife)
    {
        $this->wife = $wife;
    }

    public function eat()
    {
        $food = $this->wife->getFood();
        // ...eat
    }

}
// ==============================================================================

class Male3  // Dependency inversion
{

    private $foodProvider;

    public function __construct(IFoodProvider $foodProvider)
    {
        $this->foodProvider = $foodProvider;
    }

    public function eat()
    {
        $food = $this->foodProvider->getFood();
        // ...
    }
}
