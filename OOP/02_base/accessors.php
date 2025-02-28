<?php
class Point
{
    private $x;
    private $y;
    public $z;

    public function __construct($x, $y, $z)
    {
        $this->x = $x;
        $this->y = $y;
        $this->z = $z;
    }

    public function __get($key)
    {
        echo "key = $key\n";

        if ($key == 'x') {
            echo "Значение x нельзя прочитать\n";
            return null;
        } else {
            return $this->$key;
        }
    }
}

$point = new Point(1, 2, 3);

$x = $point->x;
$y = $point->y;
$z = $point->z;
$point->abc = 'abc';

echo "x = $x\n";
echo "y = $y\n";
echo "z = $z\n";
$s = $point->abc;
echo "abc = $s\n";

