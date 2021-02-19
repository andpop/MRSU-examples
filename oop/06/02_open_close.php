<?php

interface Logger
{
    public function log();
}

class FileLogger implements Logger
{
    private function saveToFile($message) {
        // ...
    }

    public function log($message) {
        // ...
        $this->saveToFile($message);
    }
}

class DBLogger implements Logger
{
    private function saveToDB($message) {
        // ...
    }

    public function log($message) {
        // ...
        $this->saveToDB($message);
    }
}

// =======================================================================

class Product {
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

$logger = new DBLogger();
$product = new Product($logger);
$product->setPrice(10);
