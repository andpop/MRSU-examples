<?php

function outer()
{
    echo "Hello from outer\n";

    if (!function_exists('inner'))
    {
        function inner()
        {
            echo "Hello from inner\n";
        }
    }

    inner();
}

outer();
inner();

outer();
