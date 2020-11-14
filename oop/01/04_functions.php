<?php

function validatePassword($password1, $password2) {
    $errorMessage = '';
    if ($password1 != $password2) $errorMessage = 'Пароли не совпадают!';
    elseif (strlen($password1) < 6) $errorMessage = 'Минимальная длина пароля - 6 символов!';

    return $errorMessage;
}

function checkUserExistence($user, $passwordFileName) {
    $errorMessage = '';

    $passwordFile = fopen($passwordFileName, 'r');
    rewind($passwordFile);

    while (!feof($passwordFile)) {
        $line = fgets($passwordFile);
        $tmp = explode(':', $line);
        if ($tmp[0] == $user) {
            $errorMessage = 'Это имя уже занято!';
            break;
        }
    }
    fclose($passwordFile);

    return $errorMessage;
}

function addUserToFile($user, $password, $passwordFileName) {
    $passwordFile = fopen($passwordFileName, 'a+');
    //шифруем пароль
    $encodedPassword = md5($password);
    fwrite($passwordFile, "\r\n$user:$encodedPassword");
    fclose($passwordFile);
}

//======================================================================
$user = isset($_POST['user']) ? $_POST['user'] : '';
$password1 = isset($_POST['password1']) ? $_POST['password1'] : '';
$password2 = isset($_POST['password2']) ? $_POST['password2'] : '';

$errorMessage1 = $errorMessage2 = '';

$errorMessage1 = validatePassword($password1, $password2);

$errorMessage2 = checkUserExistence($user, 'userpwd.txt');

if (($errorMessage1 == '') && ($errorMessage2 == '')) {
    addUserToFile($user, $password1, 'userpwd.txt');
}
