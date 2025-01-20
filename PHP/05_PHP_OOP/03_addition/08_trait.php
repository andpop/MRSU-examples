<?php

trait Magic
{
    private $properties;

    public function __get($key)
    {
        return $this->properties[$key] ?? null;
    }

    public function __set($key, $value)
    {
        $this->properties[$key] = $value;
    }
}

class Config
{
    use Magic;
}

$config = new Config();
$config->key = 'value';
echo $config->key;
