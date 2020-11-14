<?php

class User {
    private static $user;
    private static $password1, $password2;
    private static $errorMessage1, $errorMessage2;
    private static $passwordFileName = 'userpwd.txt';

    static private function validatePassword() {
        $errorMessage = '';
        if (self::$password1 != self::$password2) $errorMessage = 'Пароли не совпадают!';
        elseif (strlen(self::$password1) < 6) $errorMessage = 'Минимальная длина пароля - 6 символов!';

        return $errorMessage;
    }

    static private function checkUserExistence() {
        $errorMessage = '';

        $passwordFile = fopen(self::$passwordFileName, 'r');
        rewind($passwordFile);

        while (!feof($passwordFile)) {
            $line = fgets($passwordFile);
            $tmp = explode(':', $line);
            if ($tmp[0] == self::$user) {
                $errorMessage = 'Это имя уже занято!';
                break;
            }
        }
        fclose($passwordFile);

        return $errorMessage;
    }

    static private function addUserToFile() {
        $passwordFile = fopen(self::$passwordFileName, 'a+');
        //шифруем пароль
        $encodedPassword = md5(self::$password1);
        fwrite($passwordFile, "\r\n".self::$user.":$encodedPassword");
        fclose($passwordFile);
    }

    static function register($user, $password1, $password2) {
        self::$user = $user;
        self::$password1 = $password1;
        self::$password2 = $password2;

        self::$errorMessage1 = self::validatePassword();
        self::$errorMessage2 = self::checkUserExistence();

        if ((self::$errorMessage1 == '') && (self::$errorMessage2 == '')) {
            self::addUserToFile();
        }

    }

}


//======================================================================

User::register($_POST['user'], $_POST['password1'], $_POST['password2']);

//======================================================================
//
// registerUser(...) и User::register(...)