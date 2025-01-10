$Path0="\\file_server\09_������" # ��������� �������
$DirMask="*_??" # ����� ��� ������ �����
$LimitMb=500 # ����������� ���������� ������ ������ ����� � ����������

cd $Path0
$Dirs=(dir | where {$_.PSIsContainer -and ($_.Name -like $DirMask)})
$n=$Dirs.length
write-host "�� ����� $Dirmask ������� $n �������(��)"
write-host "��������� ������ ���������..."
# ��� ������� ����������� �������� ��������� ��� ������.��������� -  � ��������� �������� $Dirs
$Dirs=($Dirs | select-object Name, @{Name="Size";`
  Expression={(dir -Path $_.Name -Recurse | Measure-Object -Property length -Sum).Sum/(1024*1024)}})
$Dirs=($Dirs | where {$_.Size -gt $LimitMb}) # ��������� � ��������� ������ �������� � ��������, ������� ������������� �������
$n=$Dirs.length
write-host "��������� ����� $n ���������"

$sender = "popov-av@osb8589.nnov.sbrf.ru"
$recipient = "popov-av@osb8589.nnov.sbrf.ru"
$server = "post8589"
$subject = "����� � ���������"
$body = "����� ������������ "+[DateTime]::Now+"`n" 
$body+="����������� ����� "+$Path0+ " �� ����� "+$DirMask+"`n"
$body+="����������� ���������� ������ ������ �����: "+$LimitMb+" ��`n����������:`n`n"


foreach ($Dir in $Dirs) {
  $body+=($Path0+"\"+$Dir.Name+", ������="+[math]::round($Dir.Size,2))+"`n"
  }

$msg = new-object System.Net.Mail.MailMessage $sender, $recipient, $subject, $body
$client = new-object System.Net.Mail.SmtpClient $server
$client.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
$client.Send($msg)