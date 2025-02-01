<?php
namespace Andrey\ExampleApp;

class B extends A
{
    
    public function bye()
    {
        $c = new C();
        $c->hello();

        echo 'Bye from B'.PHP_EOL;
    }
}
