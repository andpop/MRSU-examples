<?php
class PowerOffState
{
    public function __construct($screen)
    {
        $this->screen = $screen;
    }

    public function touch()
    {
        // ничего не происходит
    }

    public function swipe()
    {
        // ничего не происходит
    }
}

class ScreenDisabledState
{
    public function __construct($screen)
    {
        $this->screen = $screen;
    }

    public function touch()
    {
        // Включаем экран. В конструктор нужно передать сам экран.
        $this->screen->state = new ScreenOnState($this->screen);
        // Оповещаем текущую программу об активации
        $this->screen->notify('touch');
    }

    public function swipe()
    {
        // ничего не происходит
    }
}


class ScreenOnState
{
    public function __construct($screen)
    {
        $this->screen = $screen;
    }

    public function touch()
    {
        $this->screen->notify('touch');
    }

    public function swipe()
    {
        $this->screen->notify('swipe');
    }
}


class MobileScreen
{
    public $state;

    public function __construct()
    {
        // Начальное состояние
        // Внутрь передается текущий объект
        // Это нужно для смены состояний (примеры ниже)
        $this->state = new PowerOffState($this);
    }

    public function notify($message)
    {
        echo $message.PHP_EOL;
    }

    public function powerOn()
    {
        // Предыдущее состояние нас не волнует
        // Все данные хранятся в самом экране
        // Объекты-состояния не имеют своих данных
        $this->state = new ScreenDisabledState($this);
    }

    public function touch()
    {
        $this->state->touch();
    }

    public function swipe()
    {
        $this->state->swipe();
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
