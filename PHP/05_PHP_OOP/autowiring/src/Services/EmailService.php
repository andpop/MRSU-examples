<?php

namespace App\Services;

class EmailService
{
    public function sendEmail(string $to, string $subject, string $body): void
    {
        echo "Sending email to $to with subject '$subject' and body '$body'.\n";
    }
}
