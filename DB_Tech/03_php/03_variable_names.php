<?php

//получаем логин и пароль
$user = isset($_POST['user']) ? $_POST['user'] : '';
$password1 = isset($_POST['password1']) ? $_POST['password1'] : '';
$password2 = isset($_POST['password2']) ? $_POST['password2'] : '';

//сообщение об ошибке
$errorMessage1 = $errorMessage2 = '';

//проверяем пароли на идентичность и минимальную длину
if ($password1 != $password2) $errorMessage1 = 'Пароли не совпадают!';
elseif (strlen($password1) < 6) $errorMessage1 = 'Минимальная длина пароля - 6 символов!';

//проверяем пользователя на существование
$passwordFile = fopen('userpwd.txt', 'a+');
rewind($passwordFile);

while (!feof($passwordFile)) {
    $line = fgets($passwordFile);
    $tmp = explode(':', $line);
    if ($tmp[0] == $user) {
        $errorMessage2 = 'Это имя уже занято!';
        break;
    }
}

//если ошибок не было, записываем учетные данные пользователя в файл
if (($errorMessage1 == '') && ($errorMessage2 == '')) {
    //шифруем пароль
    $encodedPassword = md5($password1);
    fwrite($passwordFile, "\r\n$user:$encodedPassword");
}

fclose($passwordFile);

//================================================================================
//    Код очень сложно повторно использовать
//================================================================================