<?php
// router.php
if (preg_match('/\.(?:png|jpg|jpeg|gif)$/', $_SERVER["REQUEST_URI"])) {
    return false;    // сервер возвращает файлы напрямую.
} else {
    echo "<p>Добро пожаловать в PHP</p>";
}

