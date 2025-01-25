<?php

function createUser(string $username, string $email, int $age = null)
{
    return [
        'username' => $username,
        'email' => $email,
        'age' => $age ?? 'Не указан',
    ];
}

/* Вызов функции с позиционными аргументами */
$user = createUser('ivan_ivanov', 'ivan@example.com');
print_r($user);

/* Вызов функции с именованными аргументами */
$user = createUser(
    username: 'ivan_ivanov',
    email: 'ivan@example.com'
);

print_r($user);
