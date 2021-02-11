<?php

class User
{
    public function __construct($id, $name)
    {
        $this->id = $id;
        $this->name = $name;
    }

    public function equals($user)
    {
        return $this->id === $user->id;
    }
}

// Для приложения (логически) это один пользователь
// Для PHP (физически) это разные объекты
$user1 = new User(12, 'Ivanov');
$user2 = new User(12, 'Ivanov');

echo json_encode($user1 === $user2).PHP_EOL; //false
echo json_encode($user1->equals($user2)).PHP_EOL; // true

$user3 = new User(10, 'Ivanov');

$user1->equals($user3); // false
