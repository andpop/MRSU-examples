#!/bin/bash
rm table.html
echo "table.html deleted"
pwsh Get-Calendar_linux.ps1
echo "table.html created"
vim table.html
