<?php

function outer()
{
    echo "Hello from outer\n";

    function inner()
    {
        echo "Hello from inner\n";
    }

    inner();
}

outer();
inner();

// Будет ошибка - определение уже определенной функции inner
outer();
