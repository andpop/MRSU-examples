<?php

class Squares implements Iterator
{
    private $start, $end;
    private $current;

    public function __construct(int $start, int $end)
    {
        $this->start = $start;
        $this->end = $end;
    }

    public function rewind()
    {
        echo "rewind" . PHP_EOL;
        $this->current = $this->start;
    }

    public function key()
    {
        echo "key: $this->current" . PHP_EOL;
        return $this->current;
    }

    public function current()
    {
        $result = $this->current * $this->current;
        echo "current: $result" . PHP_EOL;
        return $result;
    }

    public function next()
    {
        $result = $this->current++;
        echo "next: $result" . PHP_EOL;
    }

    public function valid()
    {
        $result = $this->current <= $this->end;
        echo "valid: {$result}" . PHP_EOL;
        return $result;
    }
}


$sequence = new Squares(3, 6);

foreach ($sequence as $key => $value) {
    echo "===== $key: $value ======" . PHP_EOL;
}
