<?php

$reporter = new Reporter();

/* Побочный эффект - чтение файла с диска */
/* Чистая функция - обработка данных, преобразование их к нужному виду */
/* $report = $reporter->generate('/path/to/report'); */

$data = file_get_contents('/path/to/report');  // Побочный эффект
$report = $reporter->generate($data);          // Чистая функция

// Получили универсальность, независимость от источника получения данных
$report = $reporter->generate(file_get_contents('https://ru.hexlet.io/reporters/3'));
