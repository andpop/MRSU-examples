<?php
require_once('./03_functions.php');

$mysqli = db_connect();
$mysqli->set_charset("utf8");

class Vendor 
{
    private $id;
    public $name, $city, $percent;
    
    public function __construct($id)
    {
        $query = "SELECT `name`, `city`, `percent` FROM vendor WHERE `id` = {$id}";
        $row = getRow($query);
        $this->id = $id;
        $this->name = $row['name'];
        $this->city = $row['city'];
        $this->percent = $row['percent'];
    }

    public function __toString()
    {
        return "{$this->name} {$this->city} {$this->percent}\n";
    }

    public function save()
    {
        $data = [];
        $data['name'] = $this->name;
        $data['city'] = $this->city;
        $data['percent'] = $this->percent;
        setRow('vendor', $this->id, $data);
    }
}

$vendor = new Vendor(1001);
echo $vendor;

$vendor->name = 'Потапкин';
$vendor->save();

$vendor = new Vendor(1001);
echo $vendor;
