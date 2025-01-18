<?php

$a = 'global';

function outer()
{
    echo "--------------------------\n";
    $a = 'outer';

    echo "Hello from outer\n";
    echo "a = $a \n";

    function inner()
    {
        echo "--------------------------\n";
        echo "Hello from inner\n";
        
        global $a;
        echo "a = $a \n";
    }

    inner();
}

outer();
inner();
