<?php
function createLog($file) {
    $f = fopen($file, 'a');
    while (true) {
        $line = yield;      # бесконечно "слушаем" метод send() для установки нового значения $line;
        fwrite($f, $line);
    }
}

$log = createLog('log.txt');
$log->send("First\n");
$log->send("Second\n");
$log->send("Third\n");
