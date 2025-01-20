<?php

namespace My1

{
//    echo __NAMESPACE__ . PHP_EOL;

    class MyClass
    {
        public function __construct()
        {
            echo __CLASS__ . PHP_EOL;
        }
    }

    $class = new MyClass();

}

namespace MyBase\My2

{
//    echo __NAMESPACE__ . PHP_EOL;
    use \My1\MyClass as My1MyClass;

    class MyClass
    {
        public function __construct()
        {
            echo __CLASS__ . PHP_EOL;
        }
    }

    $class1 = new MyClass();
    $class2 = new My1MyClass();

}
