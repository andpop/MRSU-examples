<?php

namespace Popov\Lection3\Ex1;

class StaticExample
{
    static public $name = "Ваня";

    public static function say()
    {
        echo "Привет, " . self::$name . "!" . PHP_EOL;
    }

    public function speak()
    {
        echo self::$name . PHP_EOL;
    }
}

$a = new StaticExample();
$a->speak();

StaticExample::say();

StaticExample::$name = "Петя";

StaticExample::say();

$a->speak();
