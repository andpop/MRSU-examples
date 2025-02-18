<?php

namespace App\Managers;

use App\Services\EmailService;

class UserManager
{
    private EmailService $emailService;

    // Конструктор принимает EmailService как зависимость
    public function __construct(EmailService $emailService)
    {
        $this->emailService = $emailService;
    }

    public function createUser(string $email): void
    {
        echo "Creating user with email $email.\n";
        $this->emailService->sendEmail($email, 'Welcome', 'Thank you for signing up!');
    }
}
