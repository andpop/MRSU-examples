<?php
class MobileScreen
{
    public function __construct()
    {
        // В самом начале телефон выключен
        $this->powerOn = false;
        $this->screenOn = false;
    }

    private function notify($message)
    {
        echo $message.PHP_EOL;
    }

    // Включение питания
    public function powerOn()
    {
        $this->powerOn = true;
    }

    // Прикосновение
    public function touch()
    {
        // Если питание выключено, то ничего не происходит
        if (!$this->powerOn) {
            return;
        }

        // Если экран был выключен, то его надо включить
        if (!$this->screenOn) {
            $this->screenOn = true;
        }

        // На событие должно реагировать текущее активное приложение
        $this->notify('touch');
    }

    // Смахивание
    public function swipe() {
        // Если выключено питание или экран, то ничего не происходит
        if (!$this->powerOn || !$this->screenOn) {
            return;
        }

        // На событие должно реагировать текущее активное приложение
        $this->notify('swipe');
    }
}


// ===== Клиентский код ===================
$screen = new MobileScreen();
$screen->touch();

$screen->powerOn();
$screen->touch();
$screen->swipe();
