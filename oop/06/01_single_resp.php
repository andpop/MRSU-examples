<?php

class Reporter1
{
    public function generate(string $filePath)
    {
        // 1. Чтение файла с диска - побочный эффект
        // 2. Обработка данных, формирование отчета - чистая функция 
    }
}

class Reporter2
{
    public function generate(string $data)
    {
        // Обработка данных, формирование отчета - чистая функция 
    }
}


$reporter1 = new Reporter1();
$reporter2 = new Reporter2();

$report = $reporter1->generate('data.txt');

// --------------------------------------------

$data = file_get_contents('data.txt'); 
//
// Получили универсальность, независимость от источника получения данных
$report = $reporter2->generate($data);
