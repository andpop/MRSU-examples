<?php

// Интерфейс сотрудника, проводящего собеседование
interface Interviewer
{
    public function askQuestions();
}

// Реализация интерфейса - задаем вопросы о разработке
class Developer implements Interviewer
{
    public function askQuestions()
    {
        echo 'Asking about design patterns!' . PHP_EOL;
    }
}

// Реализация интерфейса - задаем вопросу о коммуникациях с людьми
class CommunityExecutive implements Interviewer
{
    public function askQuestions()
    {
        echo 'Asking about community building' . PHP_EOL;
    }
}


// Абстрактная кадровичка
abstract class HiringManager
{
    // Фабричный метод - полиморфизм
    abstract public function makeInterviewer(): Interviewer;

    public function takeInterview()
    {
        $interviewer = $this->makeInterviewer();
        $interviewer->askQuestions();
    }
}

// Менеджер по разработке
class DevelopmentManager extends HiringManager
{
    public function makeInterviewer(): Interviewer
    {
        return new Developer();
    }
}

// Менеджер по маркетингу
class MarketingManager extends HiringManager
{
    public function makeInterviewer(): Interviewer
    {
        return new CommunityExecutive();
    }
}


$devManager = new DevelopmentManager();
$devManager->takeInterview(); // Output: Спрашивает о шаблонах проектирования.

$marketingManager = new MarketingManager();
$marketingManager->takeInterview(); // Output: Спрашивает о создании сообщества.
