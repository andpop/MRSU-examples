<?php

function createUser(string $username, string $email, int $age = null)
{
    return [
        'username' => $username,
        'email' => $email,
        'age' => $age ?? 'Не указан',
    ];
}

$user = createUser(
    username: 'ivan_ivanov',
    email: 'ivan@example.com'
);

print_r($user);
