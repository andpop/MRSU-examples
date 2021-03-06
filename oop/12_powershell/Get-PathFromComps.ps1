#########################################################################################################
# Имя:      Get-PathFromComps.ps1
# Автор:    Попов
# Описание: Получение значения переменной Path и выделение из нее сетевого пути 
#########################################################################################################

# Add-PSSnapin Quest.ActiveRoles.ADManagement
# Set-QADPSSnapinSettings -DefaultSizeLimit 0
# Get-QADComputer -SearchRoot 'tb42.vvb.sbrf.ru/TB42/_8589/PCs' | Where-Object {$_.whenChanged.Date -ge (Get-Date).AddDays(-45)} | ft Name, whenChanged 

$CurDir = $MyInvocation.MyCommand.Definition |Split-Path -Parent  # Путь к текущему каталогу, откуда запущен скрипт
$ComputerList = "$CurDir\bad_comps_20161217.txt"  # Файл со списком компьютеров
$OutFile = "$CurDir\path_from_bad_comps_20161217.csv"                                    # Выходной csv-файл

if (Test-Path $OutFile){del $OutFile}
$CompCurrentNomer = 0


#gc $ComputerList | Where-Object {Test-Connection $_ -Count 2 -Quiet} | ForEach-Object {
#    $Comp = $_
#    $PathValue = ""
#    Get-WmiObject win32_environment -computername $Comp | Where-Object {$_.Name -eq "Path"} | ForEach-Object {$CompCurrentNomer++; $CompCurrentNomer; 
#        $PathValue = $_.VariableValue; if ($PathValue -match "^.+(\\\\.*?);.*$"){$NetPath = $matches[1]; $s = "$Comp;$NetPath"; $s >> $OutFile}
#        }
#    }

gc $ComputerList | ForEach-Object {
    $CompCurrentNomer++
    $CompCurrentNomer; 

    $Comp = $_
    $s = "$Comp;"
    $PathValue = ""
    if (-not (Test-Connection $_ -Count 2 -Quiet)) {$s += "Offline"} 
    else {
        $s += "Online;";
        Get-WmiObject win32_environment -computername $Comp | Where-Object {$_.Name -eq "Path"} | 
            ForEach-Object {
            $PathValue = $_.VariableValue; 
            if ($PathValue -match "^.+(\\\\.*?);.*$"){$NetPath = $matches[1]; $s += "$NetPath"} else {$s += "Local_path"}
            }
        }
    $s >> $OutFile
    }


# Get-WmiObject win32_environment -computername 8589-W_0003304 | Where-Object {$_.Name -eq "Path"} | % {$_.VariableValue}