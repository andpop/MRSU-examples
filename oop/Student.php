<?php
namespace Popov\Labs;


class Student
{
    private static $lastId = 0;

    private $id;
    private $lastname;
    private $name;
    private $faculty;

    public function __construct($name, $lastname, $faculty)
    {
        $this->id = ++self::$lastId;
        $this->name = $name;
        $this->lastname = $lastname;
        $this->faculty = $faculty;
    }

    public function __toString()
    {
        return $this->id . ". " . $this->name . " " . $this->lastname . ". " . $this->faculty . PHP_EOL;
    }
}

class StudentList implements \Iterator
{
    private $studentArray = [];
    private $position = 0;

    public function __construct()
    {
        $this->position = 0;
    }

    public function rewind()
    {
        $this->position = 0;
    }

    public function key()
    {
        return $this->position;
    }

    public function current()
    {
        return $this->studentArray[$this->position];
    }

    public function next()
    {
        ++$this->position;
    }

    public function valid()
    {
        return isset($this->studentArray[$this->position]);
    }

    public function addStudent($name, $lastname, $faculty)
    {
        $student = new Student($name, $lastname, $faculty);
        $this->studentArray[] = $student;
    }


}

$studentList = new StudentList();
$studentList->addStudent("Иван", "Петров", "Математический");
$studentList->addStudent("Петр", "Иванов", "Иняз");

foreach ($studentList as $student) {
    echo $student;
}
