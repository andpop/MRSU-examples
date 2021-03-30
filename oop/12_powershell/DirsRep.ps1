$Path0="\\file_server\09_оииабр" # Начальный каталог
$DirMask="*_??" # Маска для личных папок
$LimitMb=500 # Максимально допустимый размер личной папки в мегабайтах

cd $Path0
$Dirs=(dir | where {$_.PSIsContainer -and ($_.Name -like $DirMask)})
$n=$Dirs.length
write-host "По маске $Dirmask найдено $n каталог(ов)"
write-host "Вычисляем размер каталогов..."
# Для каждого подходящего каталога вычисляем его размер.Результат -  в коллекции объектов $Dirs
$Dirs=($Dirs | select-object Name, @{Name="Size";`
  Expression={(dir -Path $_.Name -Recurse | Measure-Object -Property length -Sum).Sum/(1024*1024)}})
$Dirs=($Dirs | where {$_.Size -gt $LimitMb}) # Оставляем в коллекции только каталоги с размером, большим максимального предела
$n=$Dirs.length
write-host "Превышают лимит $n каталогов"

$sender = "popov-av@osb8589.nnov.sbrf.ru"
$recipient = "popov-av@osb8589.nnov.sbrf.ru"
$server = "post8589"
$subject = "Отчет о каталогах"
$body = "Отчет сгенерирован "+[DateTime]::Now+"`n" 
$body+="Проверялась папка "+$Path0+ " по маске "+$DirMask+"`n"
$body+="Максимально допустимый размер личной папки: "+$LimitMb+" Мб`nНарушители:`n`n"


foreach ($Dir in $Dirs) {
  $body+=($Path0+"\"+$Dir.Name+", размер="+[math]::round($Dir.Size,2))+"`n"
  }

$msg = new-object System.Net.Mail.MailMessage $sender, $recipient, $subject, $body
$client = new-object System.Net.Mail.SmtpClient $server
$client.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
$client.Send($msg)