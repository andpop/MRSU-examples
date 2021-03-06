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
        $this->current = $this->start;
    }

    public function key()
    {
        return $this->current;
    }

    public function current()
    {
        $result = $this->current * $this->current;
        return $result;
    }

    public function next()
    {
        $result = $this->current++;
    }

    public function valid()
    {
        return $this->current <= $this->end;
    }
}

class SequenceFilterIterator extends FilterIterator
{
    public function accept()
    {
        return parent::current() <= 25;
    }
}


$sequence = new Squares(3, 7);
$filteredSequence = new SequenceFilterIterator($sequence);

foreach ($sequence as $key => $value) {
    echo "$key: $value". PHP_EOL;
}

echo "Filtered sequence: ".PHP_EOL;

foreach ($filteredSequence as $key => $value) {
    echo "$key: $value". PHP_EOL;
}

