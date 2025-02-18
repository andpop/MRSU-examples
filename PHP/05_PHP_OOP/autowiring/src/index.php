<?php
require_once __DIR__ . '/../vendor/autoload.php';

use DI\ContainerBuilder;
use App\Managers\UserManager;

// Создаем контейнер
$containerBuilder = new ContainerBuilder();
$container = $containerBuilder->build();

// Получаем экземпляр UserManager из контейнера
$userManager = $container->get(UserManager::class);

// Используем метод createUser
$userManager->createUser('user@example.com');
