# Скрипт выбирает пользователей интернета, для синхронизации доменов.
# Признак пользователя интернета устанавливается в поле PostOfficeBox:
# 0 - Новый пользователь интернета без п/я
# 1 - Активный пользователь интернета
# 2 - Удаленный пользователь интернета

## Для работы с AD
Add-PSSnapin Quest.ActiveRoles.ADManagement
Set-QADPSSnapinSettings -DefaultSizeLimit 0
cls

# Указываем рабочую директорию. В ней будут храниться рабчие и временные файлы для синхронизации
# run.ps1           - сам скрипт
# template_new.csv  - шаблон для создания CSV файла, который служит для заведения п/я в домене SBERBANK.RU
# SyncUsr.xml       - файл XML, в котором содержатся все данные пользователей, необходимые для синхронизации
# NewUsr.xml        - файл XML, в котором содержатся данные новых пользователей интернета
# DelUsr.xml        - файл XML, в котором содержатся имя удаленных пользователей

# Путь для запуска на сервере
#sl C:\script\SyncInet

# Путь для локального запуска
sl D:\_Scripts\_2016\SyncInet

# --------------------------
# Формируем XML файлы
# --------------------------

# 1. Записываем нужные данные пользователя в файл синхронизации SyncUsr.xml
#
# Для синхронизации выбираются следующие поля:
# Name          - полное имя пользователя (используется для идентификации пользователей)
# DisplayName   - отображаемое имя пользователя
# FirstName     - имя
# LastName      - фамилия
# Initials      - инициалы
# Description   - описание
# PostalCode    - почтовый индекс (табельный номер)
# Pager         - пейджер (тоже табельный номер)
# Title         - должность
# Department    - отдел
# Company       - организация
# MemberOf      - группы

Get-QADUser -SearchRoot "tb42.vvb.sbrf.ru/TB42/_8589" | ?{($_.PostOfficeBox -eq "1") -and !($_.Pager -match "^99")} | 
Select-Object Name, LogonName, DisplayName, FirstName, LastName, Initials, Description, PostalCode, Pager, Title, Department, Company, MemberOf | 
Export-Clixml .\SyncUsr.xml


# 2. Записываем нужные данные новых пользователя в файл синхронизации NewUsr.xml
# Если временный файл существует (т.е. есть новые пользователи), то формируем XML файл с данными пользователей.
# Для синхронизации выбираются следующие поля:
# LogonName           - логин пользователя
# Name                - полное имя пользователя (используется для идентификации пользователей)
# DisplayName         - отображаемое имя пользователя
# FirstName           - имя
# LastName            - фамилия
# Initials            - инициалы
# Description         - описание
# PostalCode          - почтовый индекс (табельный номер)
# Pager               - пейджер (тоже табельный номер)
# Title               - должность
# Department          - отдел
# Company             - организация
# SamAccountName      - имя учетной записи SAM
# UserPrincipalName   - 
# MemberOf            - группы

Get-QADUser -SearchRoot "tb42.vvb.sbrf.ru/TB42/_8589" | ?{($_.PostOfficeBox -eq "0") -and !($_.Pager -match "^99")} | 
Set-QADUser -PostOfficeBox "1" | 
Select-Object LogonName, Name, DisplayName, FirstName, LastName, Initials, Description, PostalCode, Pager, Title, Department, Company, SamAccountName, UserPrincipalName, MemberOf | 
Export-Clixml .\NewUsr.xml

# -----------------------------------------------
# Формируем CSV файл на п/я новых пользоватей
# -----------------------------------------------
# После того, как XML файл создан, формируем файл для создания п/я в домене SBERBANK.RU
# Собираем данные пользователя для ящика по следующей схеме
# displayName       – отображаемое имя пользователя в Адресной книге
# Type              – тип пользователя
# Title             – должность сотрудника
# smtpTB            - корпоративная почта пользователя
# после чего формируем временный файл с выбранными данными пользователя построчно.
Import-Clixml .\NewUsr.xml | %{Get-QADUser $_.Name -SearchRoot "tb42.vvb.sbrf.ru/TB42/_8589" | ?{($_.PostOfficeBox -eq "1") -and !($_.Pager -match "^99")} | %{
    $Name = $_.DisplayName
    if ($_.Displayname -match '^(\d+) (.*)') {$Name = $matches[2]}
	#$s = $_.Name -replace "^\d{4} ";
	$s = $Name + ";User;" + $_.Title + " " + $_.Department + " ОСБ №8589" + ";" + $_.mail;
	Out-File .\tmp_user.~~1 -InputObject $s -Append
	}}

# Формируем имя результирующего файл
if (Test-Path .\tmp_user.~~1) {
    # Из шаблона создаем шапку CSV файла
    copy .\template_new.csv -Destination .\tmp_head.~~1
    $endfile = Get-Date -UFormat "%d.%m.%Y_%H.%M.%S"
    $endfile = $endfile + "_VVB.csv"
    # Собираем конечный файл
    gc .\tmp_head.~~1, .\tmp_user.~~1 > .\$endfile
    }


# 3. Записываем нужные данные удаленных пользователя в файл синхронизации DelUsr.xml
# Если временный файл существует (т.е. есть пользователи для удаления), то формируем XML файл с данными пользователей.
# Для синхронизации выбираются следующие поля:
# LogonName           - логин пользователя
# Name                - полное имя пользователя (используется для идентификации пользователей)
Get-QADUser -SearchRoot "tb42.vvb.sbrf.ru/TB42/_8589" | ?{$_.AccountIsDisabled -and ($_.PostOfficeBox -eq "1")} | Set-QADUser -PostOfficeBox "2" | Select-Object LogonName, Name | Export-Clixml .\DelUsr.xml

# Отправляем почтовые сообщения
# Обнуляем счетчики новых пользователей
$numdel = 0
$namdel = ""
# Формируем строчки с новыми пользователями
Import-Clixml .\DelUsr.xml | %{$numdel = $numdel + 1; $namdel = $namdel + $_.Name+" (" + $_.LogonName + ")`n"}

# Обнуляем счетчики удаленных пользователей
$numnew = 0
$namnew = ""
# Формируем строчки с удаленными пользователями
Import-Clixml .\NewUsr.xml | %{$numnew = $numnew + 1; $namnew = $namnew + $_.Name + " (" + $_.LogonName + ")`n"}

# От кого отправляется сообщение
$frmml = "8589-Exec@nnov.sbrf.ru"
# Шифруем пароль
$pass = ConvertTo-SecureString "garbon96zhkh" -AsPlainText -Force
# Переменая с пользователем от кого отправлять и его пароль
$cred = New-Object System.Management.Automation.PSCredential($frmml, $pass)
# Кому отправлять сообщение
$to = "8589-Popov-AV@nnov.sbrf.ru"
# Тема сообщения
$sbj = "Отчет"
# Кому отправлять копию сообщения
$cc = "8589-Shikin-EA@nnov.sbrf.ru"
# С какого SMTP сервера отпралять
$smtpserv = "8589-S-ES-03.tb42.vvb.sbrf.ru"
# Формируем тело письма
$bodymail = ""
$bodymail = Get-Date -UFormat "%d.%m.%Y`n"
$bodymail = $bodymail + "`nУдаленных пользователей - " + $numdel + ":`n"
$bodymail = $bodymail + $namdel + "`n`n"
$bodymail = $bodymail + "Новых пользователей - " + $numnew + ":`n"
$bodymail = $bodymail + $namnew
if ($numnew -ne "0") {$bodymail = $bodymail + "`nСоздан файл на создание новых почтовых ящиков: " + $endfile}
# Отправляем письмо
Send-MailMessage -From $frmml -To $to -Subject $sbj -Cc $cc -Body $bodymail -SmtpServer $smtpserv -Credential $cred -Encoding ([System.Text.Encoding]::BigEndianUnicode)

# Копируем куда нада сформированные файлы XML
#move .\*.xml \\8589-s-fs-01\Интернет\Sync\ -Force
move .\*.xml \\0042-s-ub-fa1\fx$\8589\Sync\ -Force
# Путь на старом сервере
#move .\*VVB.csv "\\8589-s-fs-01\_Обмен\33_ОИТ\_Общая\Заявки интернет\" -Force
move .\*VVB.csv "\\fs-netapp-ank1\8589$\_Обмен\33_ОИТ\_Общая\_Заявки интернет" -Force

# Удаляем временные файлы *.~~1
del .\*.~~1

