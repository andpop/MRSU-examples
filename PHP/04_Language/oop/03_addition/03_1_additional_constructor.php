<?php

namespace Popov\Lection3\Ex3_1;

//Задача: нужно создавать пользователей, имеющих разные роли (администратор, оператор, аудитор)

class User
{
    const ADMIN_ROLE = 1;
    const AUDITOR_ROLE = 2;
    const OPERATOR_ROLE = 3;

    private $name;

    public function __construct($name, $userType)
    {
        $this->name = $name;

        switch ($userType) {
            case self::ADMIN_ROLE:
                echo "Создаем администратора ($name)" . PHP_EOL;
                break;
            case self::AUDITOR_ROLE:
                echo "Создаем аудитора ($name)".PHP_EOL;
                break;
            case self::OPERATOR_ROLE:
                echo "Создаем оператора ($name)".PHP_EOL;
                break;
        }
    }
}


$admin = new User('Ivanov-AS', User::ADMIN_ROLE);
$auditor = new User('Petrov-AF', 2);
$operator = new User('Sidorov-IG', 3);
