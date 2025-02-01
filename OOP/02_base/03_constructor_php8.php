<?php
class Student
{
    public function __construct(
        public string $name, 
        public string $lastName)
    { }
}

$student1 = new Student("Сергей", "Иванов");
$student2 = new Student(name: "Иван", lastName: "Сергеев");
