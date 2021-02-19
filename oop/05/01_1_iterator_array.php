<?php

class MyIterator implements Iterator
{
    private $innerArray = [];

    public function __construct(array $array)
    {
        $this->innerArray = $array;
    }

    public function rewind()
    {
        echo "rewind" . PHP_EOL;
        reset($this->innerArray);
    }

    public function key()
    {
        $result = key($this->innerArray);
        echo "key: $result" . PHP_EOL;
        return $result;
    }

    public function current()
    {
        $result = current($this->innerArray);
        echo "current: $result" . PHP_EOL;
        return $result;
    }

    public function next()
    {
        $result = next($this->innerArray);
        echo "next: $result" . PHP_EOL;
    }

    public function valid(): bool
    {
        $result = $this->current() !== false;
        echo "valid: {$result}" . PHP_EOL;
        return $result;
    }
}

$values = ['a', 'b', 'c', 'd'];

$iterator = new MyIterator($values);

foreach ($iterator as $key => $value) {
    echo "===== $key: $value ======" . PHP_EOL;
}
