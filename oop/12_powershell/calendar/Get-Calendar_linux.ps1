$CurrentDirectory = $MyInvocation.MyCommand.Definition | split-path -parent
$OutFile = $CurrentDirectory+'\table.html'
if (Test-Path $OutFile) {Remove-Item $OutFile}

$Monday = (Get-Date -Year 2021 -Month 3 -Day 29)
# [int]$Monday.DayOfWeek   1-Понедельник

function Get-Saints ($MonthDay, [switch]$NeedWeekName) {
    
    $Request = 'http://script.days.ru/calendar.php?advanced=1&date='+$MonthDay+'&ssi=1&hram=0'
    $Content=[System.Web.HttpUtility]::HtmlDecode((Invoke-WebRequest $Request -SkipCertificateCheck).RawContent)

    # $Content

    $Content -match '<div><!--saints-->.*</div>' > null
    $Saints=$Matches[0]
    
    $Saints = $Saints -replace '<.*?>'
    $Saints = $Saints -replace '\(икона\)'
    $Saints = $Saints -replace '  ', ' '
    $Saints = $Saints -replace ' ,', ','
    $Saints = $Saints -replace ' \.', '.'
    
    if ($NeedWeekName) {
        $Content -match '<!--sedm-->.*?<' > null
        $WeekName = $Matches[0]
        $WeekName = $WeekName -replace '<.*?>'
        $WeekName = $WeekName -replace '<'
        $Saints = $WeekName+$Saints
        $Saints
    }
    $Saints

}

function Out-TableHeader {
    '<table class="alignleft schedule">' >> $OutFile
    '<tbody>' >> $OutFile
}

function Out-TableFooter {
    '</tbody>' >> $OutFile
    '</table>' >> $OutFile
}

function Out-TableRow ($RowDate, $RowSaints, $RowWorships){
    # Название дня недели, первая буква заглавная
    $DayOfWeekRus = ((Get-Culture).DateTimeFormat.GetDayName($RowDate.DayOfWeek))
    $DayOfWeekRus = ($DayOfWeekRus.Substring(0,1).ToUpper()+$DayOfWeekRus.Substring(1))
    # Выделяем номер дня и название месяца
    # Так работало в Windows
    # $RowDate.ToLongDateString() -match '^\S+ \S+ ' > Null
    $RowDate.ToLongDateString() -match '(, )(\S+ \S+)' > Null
    $DayMonthName = $matches[2]

    $DateForTable = "$DayOfWeekRus `n $DayMonthName"

    '<!-- *********** {0} ************************************************************ -->' -f $DayOfWeekRus  >> $OutFile
    if ([int]$RowDate.DayOfWeek -eq 0) {'<tr class="red">' >> $OutFile}
    else {'<tr>' >> $OutFile}
    '<td> {0} </td>' -f $DateForTable >> $OutFile
    '<td> {0} </td>' -f $RowSaints >> $OutFile
    '<td> {0} </td>' -f $RowWorships >> $OutFile
    '</tr>' >> $OutFile
}

# ------------- Main ------------------------------------------
Out-TableHeader

1 .. 7 | foreach {
    $Date = $Monday.AddDays($_-1)

    # Святые и праздники дня
    $MD=('{0:MM}{1:dd}' -f $Date,$Date)
    if (($_ -eq 1) -or ($_ -eq 7)) {$Saints = (Get-Saints -MonthDay $MD -NeedWeekName)}
    else {$Saints = (Get-Saints -MonthDay $MD)}

    if ($_ -lt 5) 
        # Богослужения с понедельника по четверг
        {$Worships = "07:30 Часы. Божественная литургия `n 16:30 Вечернее богослужение "}
    elseif ($_ -lt 7)
        # Богослужения в пятницу и субботу
        {$Worships = "07:30 Часы. Божественная литургия `n 16:30 Всенощное бдение "} 
    else
        # Богослужения в воскресенье
        {$Worships = "08:00 Часы. Божественная литургия `n 16:30 Вечернее богослужение "} 

     
    Out-TableRow $Date $Saints $Worships
}

Out-TableFooter
"Таблица сформирована в файле $OutFile"
