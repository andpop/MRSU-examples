<?php

$u = isset($_POST['u']) ? $_POST['u'] : '';
$p1 = isset($_POST['p1']) ? $_POST['p1'] : '';
$p2 = isset($_POST['p2']) ? $_POST['p2'] : '';

$e1 = $e2 = '';
if ($p1 != $p2) $e1 = 'Пароли не совпадают!';
elseif (strlen($p1) < 6) $e1 = 'Минимальная длина пароля - 6 символов!';
$pfile = fopen('userpwd.txt', 'a+');
rewind($pfile);
while (!feof($pfile)) {
    $l = fgets($pfile);
    $tmp = explode(':', $l);
    if ($tmp[0] == $u) {
        $e2 = 'Это имя уже занято!';
        break;
    }
}
if (($e1 == '') && ($e2 == '')) {
    $up = md5($p1);
    fwrite($pfile, "\r\n$u:$up");
}
fclose($pfile);