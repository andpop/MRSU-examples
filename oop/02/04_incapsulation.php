<?php
namespace Popov\Lection2\Ex4;

class Student
{
    private $name;
    private $lastName;

    public function __construct($name, $lastName)
    {
        $this->name = $name;
        $this->lastName = $lastName;
    }

    private function getName()
    {
        return $this->name;
    }

    public function setName($name)
    {
        $this->name = $name;
    }

    public function getLastName()
    {
        return $this->lastName;
    }

    public function setLastName($lastName)
    {
        $this->lastName = $lastName;
    }

    public function getFullName()
    {
        echo "Полное имя: ".$this->name." ".$this->lastName.PHP_EOL;
    }
}


$student1 = new Student("Сергей", "Иванов");

echo $student1->getName().PHP_EOL;
//echo $student1->name;

$student1->getFullName();
$student1->setName("Николай");
$student1->getFullName();

//
////echo $student1->name;
//$student1->age = 24;
//echo $student1->age.PHP_EOL;

// PHP Fatal error:  Uncaught Error: Cannot access private property