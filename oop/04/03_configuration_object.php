<?php

$document = new Document();

// ==================================================
$document.leftMargin = 20;
$document.rightMargin = 10;
$document.range = 'all';

$document->print();
// ==================================================

$document->print(['leftMargin' => 20, 'rightMargin' => 10, 'range' => 'all']);
// ==================================================

$pageLayout = new PageLayout(['leftMargin' => 20, 'rightMargin' => 10, 'range' => 'all']);

$document->print($pageLayout);

