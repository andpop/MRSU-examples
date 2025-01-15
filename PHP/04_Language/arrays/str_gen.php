<?php

$coll = ['milk', 'butter', 'eggs', 'bread'];
// Надо получить строку
// <ul><li>milk</li><li>butter</li><li>eggs</li><li>bread</li></ul>

// ========================================================
// Плохой вариант
$result = '';
foreach ($coll as $item) {
    $result .= "<li>{$item}</li>";
    // либо так
    // $result = "{$result}<li>{$item}</li>";
}
$result = "<ul>{$result}</ul>";
echo $result . PHP_EOL;

/* ======================================================== */
// Так лучше:
// - Меньше тратится память
// - Можно дообратотать массив
// - Проще код
$parts = [];
foreach ($coll as $item) {
    $parts[] = "<li>{$item}</li>";
}
$innerValue = implode('', $parts);
$result = "<ul>{$innerValue}</ul>";
echo $result . PHP_EOL;
