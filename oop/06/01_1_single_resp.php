<?php

// ======================================================================
class WrongProduct // Сохранение в БД данных о товаре + логирование ошибок
{

    private function saveToFile($message)
    {
        // ...
    }

    private function log($message)
    {
        // ...
        $this->saveToFile($message);
    }

    public function setPrice($price)
    {
        try {
            // save price in db
        } catch (DbException $e) {
            $this->logger->log($e->getMessage());
        }
    }
}
// ======================================================================

class Logger
{
    private function saveToFile($message)
    {
        // ...
    }

    public function log($message)
    {
        // ...
        $this->saveToFile($message);
    }

}

class Product
{
    private $logger;

    public function __construct(Logger $logger)
    {
        $this->logger = $logger;
    }

    public function setPrice($price)
    {
        try {
            // save price in db
        } catch (DbException $e) {
            $this->logger->log($e->getMessage());
        }
    }
}


$logger = new Logger();
$product = new Product($logger);
$product->setPrice(10);
