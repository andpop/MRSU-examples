<?php

echo f('Сергей');

function f(string $name): string
{
    return "Hello from function, ${name}\n";
}

