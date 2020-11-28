<?php

require __DIR__ . '/../vendor/autoload.php';

use Slim\Factory\AppFactory;

$app = AppFactory::create();
$app->addErrorMiddleware(true, true, true);

/* $app->get('/', function ($request, $response) { */
/*     $response->write('Welcome to Slim!'); */
/*     return $response; */
/* }); */


$app->get('/users', function ($request, $response) {
    $response->write('List users here');
    return $response;
});

$app->post('/users', function ($request, $response) {
    $response->write('New user');
    return $response;
});

$app->run();

