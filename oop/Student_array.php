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
        return $this->name . " " . $this->lastname . ". " . $this->faculty . PHP_EOL;
    }
}

class StudentList
{
    private $studentArray = [];

    public function addStudent($name, $lastname, $faculty)
    {
        $student = new Student($name, $lastname, $faculty);
        $this->studentArray[] = $student;
    }
}

$studentList = new StudentList();
$studentList->addStudent("Иван", "Петров", "Математический");
$studentList->addStudent("Петр", "Иванов", "Иняз");

$student1 = new Student("Иван", "Петров", "Математический");
$student2 = new Student("Петр", "Иванов", "Иняз");

//echo $student1->__toString();
//echo $student1;

$studentArray = [];
$studentArray[] = $student1;
$studentArray[] = $student2;

foreach ($studentArray as $student) {
    echo $student;
}
//
//var_dump($studentArray);
//var_dump($student2);
