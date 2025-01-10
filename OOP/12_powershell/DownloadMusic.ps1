#Библиотека нужна для декодирования URL
[System.Reflection.Assembly]::LoadWithPartialName("System.web")


$StartUri = 'http://zaycev.net/musicset/top20earwormsongs.shtml'
#$StartUri = 'http://zaycev.net/musicset/goldenrussianrock.shtml'

$DownloadDir = 'D:\Mp3\20\'

$StartPage = Invoke-WebRequest $StartUri
$DownloadList = $StartPage.AllElements | Where-Object {($_.class -eq "musicset-track__link") -and ($_.href -like '/pages*')}
$DownloadList | ForEach-Object {
    $href='zaycev.net'+$_.href
    $SongHTML = Invoke-WebRequest $href
    $song = $SongHTML.AllElements | Where-Object {$_.id -eq 'audiotrack-download-link'} 
    $song | ForEach-Object {
        $HrefSong = $_.href
        $_.href -match '.*/(.*$)' 
        $Mp3FileName = $Matches[1]; 
        $Mp3FileName = [System.Web.HttpUtility]::UrlDecode($Mp3FileName)
        '========================================================='
        $Mp3FileName
        $HrefSong
        Invoke-WebRequest -Uri $HrefSong -OutFile ($DownloadDir+$Mp3FileName)
        }
}