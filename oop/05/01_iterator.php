<?php

class MyIterator implements Iterator
{
    private $innerArray = [];
    private $position = 0;

    public function __construct(array $array)
    {
        if (is_array($array)) {
            $this->innerArray = $array;
        }
        $this->position = 0;
    }

    public function rewind()
    {
        echo "rewind" . PHP_EOL;
        reset($this->innerArray);
    }

    public function key()
    {
        $var = key($this->innerArray);
        echo "key: $var" . PHP_EOL;
        return $var;
    }

    public function current()
    {
        $var = current($this->innerArray);
        echo "current: $var" . PHP_EOL;
        return $var;
    }

    public function next()
    {
        $var = next($this->innerArray);
        echo "next: $var" . PHP_EOL;
        return $var;
    }

    public function valid()
    {
        $var = $this->current() !== false;
        echo "valid: {$var}" . PHP_EOL;
        return $var;
    }
}

$values = ['a', 'b', 'c', 'd'];

$iterator = new MyIterator($values);

foreach ($iterator as $key => $value) {
    echo "===== $key: $value ======" . PHP_EOL;
}
