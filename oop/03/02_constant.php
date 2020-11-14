<?php

namespace Popov\Lection3\Ex2;


class ConstExample
{
    const INI_FILE = "config.ini";

    public function readIniFile()
    {
        echo "Конфигурационный файл: " . self::INI_FILE . PHP_EOL;
    }
}


echo ConstExample::INI_FILE . PHP_EOL;

$obj = new ConstExample;
$obj->readIniFile();

echo $obj::INI_FILE . PHP_EOL;


