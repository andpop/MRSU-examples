<?php
class MobileScreen
{
    public function __construct()
    {
        $this->stateName = 'powerOff';
    }

    private function notify($message)
    {
        echo $message.PHP_EOL;
    }

    // Включение питания
    public function powerOn()
    {
        $this->stateName = 'screenDisabled';
    }

    // Прикосновение
    public function touch()
    {
        // Если питание выключено, то ничего не происходит
        if ($this->stateName === 'powerOff') {
            return;
        }

        // Если экран был выключен, то его надо включить
        if ($this->stateName === 'screenDisabled') {
            $this->stateName = 'screenOn';
        }

        // На событие должно реагировать текущее активное приложение
        $this->notify('touch');
    }

    // Смахивание
    public function swipe() {
        // Если выключено питание или экран, то ничего не происходит
        if ($this->stateName !== 'screenOn') {
            return;
        }

        // На событие должно реагировать текущее активное приложение
        $this->notify('swipe');
    }
}


/////////////////////////////////////////////////////////////////////////////
// ===== Клиентский код ===================
/////////////////////////////////////////////////////////////////////////////

$screen = new MobileScreen();
$screen->touch();

$screen->powerOn();
$screen->touch();
$screen->swipe();
