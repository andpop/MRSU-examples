<?php

// Поиск из базы по идентификатору
// Гипотетический код
$user = $users->find(5);

$user->street; // 'lenina'
$user->zipcode; // 432111
$user->house; // 10


// ===========================================================================
// Логика по работе с данными внутри самой сущности

class User
{
    private string $street;
    private string $house;
    private string $zipcode;


    public function getFullAddress()
    {
        return "{$this->street}, {$this->house}, {$this->zipcode}";
    }
}

$user->getFullAddress();

// ===========================================================================
// Отдельный класс для адреса + внедрение объекта-адреса в класс User

class Address
{
    private string $street;
    private string $house;
    private string $zipcode;

    public function __construct($street, $house, $zipcode)
    {
        $this->street = $street;
        $this->house = $house;
        $this->zipcode = $zipcode;
    }

    public function toString()
    {
        return "{$this->street}, {$this->house}, {$this->zipcode}";
    }
}

class User
{
    private string $street;
    private string $house;
    private string $zipcode;

    public function getAddress()
    {
        return new Address($this->street, $this->house, $this->zipcode);
  }
}

$user->getAddress()->toString();
