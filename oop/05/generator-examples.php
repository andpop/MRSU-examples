<?php

//Проходимся по строкам файла
$f = fopen($file, 'r');
while ($line = fgets($f)) {
    doSomethingWithLine($line);
}

///////////////////////////////////////////////

class FileIterator implements Iterator {
    protected $f;
    protected $data;
    protected $key;
    public function __construct($file) {
        $this->f = fopen($file, 'r');
        if (!$this->f) throw new Exception();
    }
    public function __destruct() {
        fclose($this->f);
    }
    public function current() {
        return $this->data;
    }
    public function key() {
        return $this->key;
    }
    public function next() {
        $this->data = fgets($this->f);
        $this->key++;
    }
    public function rewind() {
        fseek($this->f, 0);
        $this->data = fgets($this->f);
        $this->key = 0;
    }
    public function valid() {
        return false !== $this->data;
    }
}

/////////////////////////////////////////
//То же самое через генератор
function getLines($file) {
    $f = fopen($file, 'r');
    if (!$f) throw new Exception();
    while ($line = fgets($f)) {          
        yield $line;
    }
    fclose($f);
}

foreach (getLines("someFile") as $line) {
    doSomethingWithLine($line);
}

/////////////////////////////////
//вариант с закрытием файла
function getLines($filename)
    {
        try {
            $fp = fopen($filename, 'r+');
            while (!feof($fp)) {
                yield fgets($fp);
            }
        } finally {
            var_dump('gonna close');
            fclose($fp);
        }
    }

//////////////////////////
//Отправка данных в генератор
function createLog($file) {
    $f = fopen($file, 'a');
    while (true) {          # да, опять бесконечный цикл;
        $line = yield;      # бесконечно "слушаем" метод send() для установки нового значения $line;
        fwrite($f, $line);
    }
}
$log = createLog($file);
$log->send("First");
$log->send("Second");
$log->send("Third");

///////////////////////////////////////
//Эмуляция потоков
// Сначала мы определяем каждый поток как генератор. Затем выбрасываем сигнал управления родителю, чтобы тот смог передать сигнал для работы следующему потоку. Построим такую систему, которая работает с разными источниками данных (работаем с неблокирующим вводом-выводом).
function step1() {
    $f = fopen("file.txt", 'r');
    while ($line = fgets($f)) {
        processLine($line);
        yield true;
    }
}
function step2() {
    $f = fopen("file2.txt", 'r');
    while ($line = fgets($f)) {
        processLine($line);
        yield true;
    }
}
function step3() {
    $f = fsockopen("www.example.com", 80);
    stream_set_blocking($f, false);
    $headers = "GET / HTTP/1.1\r\n";
    $headers .= "Host: www.example.com\r\n";
    $headers .= "Connection: Close\r\n\r\n";
    fwrite($f, $headers);
    $body = '';
    while (!feof($f)) {
        $body .= fread($f, 8192);
        yield true;
    }
    processBody($body);
}

// 3 потока (step) имеют схожий функционал - выбрасывают true, тем самым давая сигнал, что он еще занят

function runner(array $steps) {                    
    while (true) {                                                # снова бесконечный цикл, в котором перебираем потоки
        foreach ($steps as $key => $step) {  
             $step->next();                                    # возобновляем работу потока с с момента последнего yield
             if (!$step->valid()) {                           # проверяем, завершился ли поток и завершаем (удаляем) его
                 unset($steps[$key]);
             }
        }
        if (empty($steps)) return;                      # если потоков нет - завершаем работу
    }
}
runner(array(step1(), step2(), step3()));

//////////////////////////////////
//возврат ключей
function getRange( $max = 10 ) {
   for( $i = 0; $i < $max; $i++ ) {
    $value = $i * mt_rand();
    yield $i => $value;
   }
  }

foreach (getRange(PHP_INT_MAX) as $key => $value ) {
   echo "Ключ {$key} имеет значение {$value}";
  }

//////////////////////
//Отсылка значений генераторам
function getRange( $max = 10 ) {
   for( $i = 1; $i < $max; $i++ ) {
    $inject = yield $i;
    if( $inject === 'stop' ) return;
   }
  }

  $generator = getRange(PHP_INT_MAX);

  foreach( $generator as $range ) {
   if($range === 10000) {
   // посылаем сообщение генератору
   $generator -> send('stop');
   }
   print "Значение {$range} <br>";
  }



