<?php

$document = new Document();


$pageLayout = new PageLayout(['leftMargin' => 20, 'rightMargin' => 10, 'range' => 'all']);

$document->print($pageLayout);

==================================================
// New confuguration instance

$pageLayout1 = new PageLayout(['leftMargin' => 5, 'rightMargin' => 5, 'range' => 'selected']);

$document->print($pageLayout1);

==================================================
// Setters (state is changed - bad!)

$pageLayout->setLeftMargin(10);
$pageLayout->setRange('selectied');

$document->print($pageLayout);

==================================================
// New options

$document->print($pageLayout, ['leftMargin' => 5, 'rightMargin' => 5]);
