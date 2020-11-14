<?php
namespace Popov\Lection2\Ex2;

class Student
{
    var $name;
    var $lastName;

    function getFullName()
    {
        echo "Полное имя: ".$this->name." ".$this->lastName.PHP_EOL;
    }
}

$student1 = new Student;

$student1->name = "Сергей";
$student1->lastName = "Иванов";
$student1->getFullName();

$student2 = new Student();
$student2->name = "Мария";
$student2->lastName = "Петрова";
$student2->getFullName();