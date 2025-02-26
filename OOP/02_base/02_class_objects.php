<?php
class Student
{
    public string $name;
    public string $lastName;

    function showFullName()
    {
        echo "Полное имя: ".$this->name." ".$this->lastName.PHP_EOL;
    }
}

// ========== Create objects ==========================

$student1 = new Student;

$student1->name = "Сергей";
$student1->lastName = "Иванов";
$student1->showFullName();

$student2 = new Student();
$student2->name = "Мария";
$student2->lastName = "Петрова";
$student2->showFullName();


// ========== Compare objects ==========================

$student2->name = "Сергей";
$student2->lastName = "Иванов";
$student2->showFullName();

// identity operator ===
echo json_encode($student1 === $student2) . PHP_EOL; //false

// comparison operator ==
echo json_encode($student1 == $student2) . PHP_EOL;  // true

$student3 = $student2;
echo json_encode($student2 === $student3) . PHP_EOL; //true

