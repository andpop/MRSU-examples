<?php
while (!feof(STDIN)) { // Пока не достигнут конец файла
    $line = fgets(STDIN); // Читаем строку
    if ($line !== false) {
        echo "Обрабатываем строку: $line";
    }
}
?>
