<?php
class Student
{
    public string $name;
    public string $lastName;

    // signatura: __construct($this, $name, $lastName)
    public function __construct(string $name, string $lastName)
    {
        $this->name = $name;
        $this->lastName = $lastName;
    }

    public function showFullName()
    {
        echo "Полное имя: ".$this->name." ".$this->lastName.PHP_EOL;
    }
}

$student1 = new Student("Сергей", "Иванов");
$student1->showFullName();

$student2 = new Student("Мария", "Петрова");
$student2->showFullName();
