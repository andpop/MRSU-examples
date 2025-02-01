<?php
namespace Popov\Lection2\Ex4;

class Student
{
    private string $name;
    private string $lastName;

    public function __construct(string $name, string $lastName)
    {
        $this->name = $name;
        $this->lastName = $lastName;
    }

    public function getName(): string
    {
        return $this->name;
    }

    public function setName(string $name): void
    {
        $this->name = $name;
    }

    public function getLastName(): string
    {
        return $this->lastName;
    }

    public function setLastName(string $lastName)
    {
        $this->lastName = $lastName;
    }

    public function showFullName()
    {
        echo "Полное имя: ".$this->name." ".$this->lastName.PHP_EOL;
    }
}


$student1 = new Student("Сергей", "Иванов");

echo $student1->getName().PHP_EOL;
//echo $student1->name;

$student1->showFullName();
$student1->setName("Николай");
$student1->showFullName();

//
////echo $student1->name;
//$student1->age = 24;
//echo $student1->age.PHP_EOL;

// PHP Fatal error:  Uncaught Error: Cannot access private property
