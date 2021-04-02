$obj = new-object -comobject "WScript.Shell"
notepad.exe
$obj.AppActivate("Блокнот")
Start-Sleep 2
$obj.SendKeys("1{+}");
Start-Sleep 5
$obj.SendKeys("2");
	