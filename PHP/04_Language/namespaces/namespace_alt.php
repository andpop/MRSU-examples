<?php
namespace Example\constants
{
    const VERSION = '1.0';
}

namespace Example\functions
{
    function debug(array|object $obj) : void
    {
        print_r($obj);
    }
}

