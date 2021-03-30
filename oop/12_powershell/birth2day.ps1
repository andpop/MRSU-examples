cls
Write-Host "*********************************************" -ForegroundColor Yellow -BackgroundColor Black
Write-Host "Сегодня именинники:" -ForegroundColor Yellow -BackgroundColor Black
$f=Get-Content .\birth.txt
$g=($f |  Where-Object {$_ -like ("????"+(get-date -uformat "%m%d")+"*")})
$g
Write-Host "*********************************************" -ForegroundColor Yellow -BackgroundColor Black
Read-Host


