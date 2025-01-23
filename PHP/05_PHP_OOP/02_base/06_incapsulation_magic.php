<?php
class Student
{
    private $name;
    private $lastName;

    public function __construct($name, $lastName)
    {
        $this->name = $name;
        $this->lastName = $lastName;
    }

    public function __get($property)
    {
        if (property_exists($this, $property)) {
            return $this->$property;
        }
    }

    public function __set($property, $value)
    {
        if ($property == "name") {
            $this->name = $value;
        };
    }

    public function showFullName()
    {
        echo "Полное имя: ".$this->name." ".$this->lastName.PHP_EOL;
    }
}


$student1 = new Student("Сергей", "Иванов");

$student1->age = 23;
echo $student1->age . PHP_EOL;

echo $student1->name.PHP_EOL;
echo $student1->lastName.PHP_EOL;

$student1->name = "Андрей";
echo $student1->name.PHP_EOL;
$student1->lastName = "Попов";
echo $student1->lastName.PHP_EOL;
