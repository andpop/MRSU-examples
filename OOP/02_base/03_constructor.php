<?php
namespace Popov\Lection2\Ex3;

class Student
{
    var $name;
    var $lastName;

    // signatura: __construct($this, $name, $lastName)
    public function __construct($name, $lastName)
    {
        $this->name = $name;
        $this->lastName = $lastName;
    }

    public function getFullName()
    {
        echo "Полное имя: ".$this->name." ".$this->lastName.PHP_EOL;
    }
}

$student1 = new Student("Сергей", "Иванов");
$student1->getFullName();

$student2 = new Student("Мария", "Петрова");
$student2->getFullName();
