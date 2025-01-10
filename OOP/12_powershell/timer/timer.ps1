<#
    .SYNOPSIS
    Always on top mini-timer

    .DESCRIPTION
    Timer for presentations (max time 59:59). Click to start, press 's' to stop, right click to input new time.  
#>

Add-Type -Assemblyname System.Windows.Forms

$CONFIG_FILE_NAME = "timer_config.psd1"
$DEFAULT_START_SECONDS = 300
$DEFAULT_WARNING_SECONDS = 60
$TIMER_WARNING_PROCENT = 20

function Format-Seconds([int]$totalSeconds) {
    $minutes = [math]::Floor($totalSeconds / 60)
    $seconds = $totalSeconds % 60

    return ([string]$minutes).PadLeft(2, "0") + ":" + ([string]$seconds).PadLeft(2, "0")
}

function Get-ConfigParameters() {
    if (-not (Test-Path "$PSScriptRoot\$CONFIG_FILE_NAME")){ 
        return @{
            startSeconds = 0; 
            warningSeconds = 0
        } 
    }

    $config = Import-PowerShellDataFile -Path "$PSScriptRoot\$CONFIG_FILE_NAME"
    
    $startSeconds = $config.startTimeMinutes * 60 + $config.startTimeSeconds
    $warningSeconds = [int]($startSeconds * $TIMER_WARNING_PROCENT / 100)

    return @{
        startSeconds = $startSeconds; 
        warningSeconds = $warningSeconds
    }
}

function Initialize-Parameters () {
    $config = Get-ConfigParameters

    $startSeconds = $config.startSeconds
    $warningSeconds = $config.warningSeconds

    if ((!$startSeconds) -or ($startSeconds -eq 0)) {$startSeconds = $DEFAULT_START_SECONDS}
    if ((!$warningSeconds) -or ($warningSeconds -eq 0)) {$warningSeconds = $DEFAULT_WARNING_SECONDS}

    return @{
        status = 'stop'; 
        startSeconds = $startSeconds; 
        leftSeconds = $startSeconds; 
        warningSeconds = $warningSeconds
    }
}

function Save-Config () {
    $startTimeMinutes = [math]::Floor($TimerState.startSeconds / 60)
    $startTimeSeconds = $TimerState.startSeconds % 60
    $configContent = @"
@{
startTimeMinutes = $startTimeMinutes
startTimeSeconds = $startTimeSeconds
}
"@
    $configContent | Out-File -FilePath "$PSScriptRoot\$CONFIG_FILE_NAME"

}


function Create-Form ([string]$text, $x, $y, $width, $height){
    $win = New-Object System.Windows.Forms.Form
    $win.StartPosition  = "Manual"
    $win.Location = New-Object System.Drawing.Size($x, $y)
    $win.Width= $width
    $win.Height = $height
    $win.Text = $text
    $win.TopMost = $True
    $win.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedToolWindow
    $win.SizeGripStyle = [System.Windows.Forms.SizeGripStyle]::Hide 
    $win.BackColor = 'gray'
    $win
}

function Create-Label ([string]$text, $x, $y, $fontSize){
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point($x, $y)
    $label.Text = $text
    $label.AutoSize = $true
    $label.Font = New-Object System.Drawing.Font("Arial", $fontSize)
    $label
}

function Create-Textbox ([string]$text, $x, $y, $fontSize){
    $textbox  = New-Object System.Windows.Forms.TextBox
    $textbox.Location = New-Object System.Drawing.Point($x, $y)
    $textbox.Text = $text
    $textbox.Font = New-Object System.Drawing.Font("Arial", $fontSize)
    $textbox.Visible = $false
    $textbox
}

function Update-Timer () {
    if (($TimerState.status -eq 'stop') -or ($TimerState.status -eq 'suspend')) {return}

    # Time expired
    if ($TimerState.leftSeconds -le 0) {
        $TimerState.status = 'stop'
        $form.BackColor = 'red'
        $timeLabel.Text = Format-Seconds($TimerState.startSeconds)
        $form.Text = ''
        return
    }

    # Time expiration warning
    if ($TimerState.leftSeconds -le $TimerState.warningSeconds) { $form.BackColor = 'yellow' }

    # Time decrement on 1 second
    $TimerState.leftSeconds--
    $timeLabel.Text = Format-Seconds($TimerState.leftSeconds)
    $form.Text = 'S - стоп'
}

function Show-Timer (){
    $form = Create-Form -text "" -x 400 -y 100 -width 170 -height 100
    $timeLabel = Create-Label -text $(Format-Seconds($TimerState.startSeconds)) -x 10 -y 10 -fontSize 30
    $newTime = Create-Textbox -text "" -x 10 -y 10 -fontSize 30
    $form.Controls.Add($timeLabel)
    $form.Controls.Add($newTime)
    $form.KeyPreview = $True

    $timer = New-Object system.windows.forms.timer
    $timer.Interval = 1000
    $timer.add_tick({Update-Timer})
    $timer.start()

    $saveParameters = {
        # Get new time from text box
        if ($_.KeyCode -eq "Enter") {
            $minSec = $newTime.Text.Split(":")
            $min = [int]$minSec[0]
            $sec = [int]$minSec[1]
            if ((0 .. 59 -contains $min ) -and (0 .. 59 -contains $sec)) {
                $TimerState.startSeconds = $min * 60 + $sec
                $TimerState.leftSeconds = $TimerState.startSeconds
                $TimerState.warningSeconds = [int]($TimerState.startSeconds * $TIMER_WARNING_PROCENT / 100)
                $TimerState.status = 'stop'
                $timeLabel.Text = Format-Seconds($TimerState.startSeconds)
                $newTime.Visible = $false
                $timeLabel.Visible = $True
                $form.Text = ''
            }
        }
    }

    $startOrSetTimer = {
        if ($_.Button -eq 'Left') {
            # Run timer by right button click
            if ($TimerState.status -eq 'stop') {
                $TimerState.status = 'run'
                $TimerState.leftSeconds = $TimerState.startSeconds
                $form.BackColor = 'green'
            }
        }
        if ($_.Button -eq 'Right') {
            # Input new values for timer. Press Enter to accept.
            $TimerState.status = 'suspend'
            $form.BackColor = 'gray'
            $form.Text = 'Enter - ввод'
            $timeLabel.Visible = $false
            $newTime.Text = Format-Seconds($TimerState.startSeconds)
            $newTime.Visible = $True
        }
    }

    $stopTimer = {
        # Stop and reset timer
        if ($_.KeyCode -eq "S") {
            $form.BackColor = 'gray'
            $form.Text = ""
            $TimerState.status = 'stop'
            $TimerState.leftSeconds = $TimerState.startSeconds
            $timeLabel.Text = Format-Seconds($TimerState.startSeconds)
        }
    }

    $form.Add_Click($startOrSetTimer)  
    $form.Add_KeyDown($stopTimer)    
    $form.Add_KeyDown($closeForm)
    $form.Add_FormClosing({$timer.stop(); Save-Config})    
    $timeLabel.Add_Click($startOrSetTimer)
    $newTime.Add_KeyDown($saveParameters)

    $form.ShowDialog()
}

# =======================================================================================

$TimerState = Initialize-Parameters
Show-Timer