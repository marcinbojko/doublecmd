
$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$scriptPath         = $(Split-Path $MyInvocation.MyCommand.Path)
$url_local          = "http://downloads.sourceforge.net/project/doublecmd/DC%20for%20Windows%2032%20bit/Double%20Commander%200.7.6%20beta/doublecmd-0.7.6.i386-win32.msi?r=&ts=1480609172&use_mirror=netcologne"
$url_remote         = "https://dl.dropboxusercontent.com/u/6066664/choco/doublecmd/doublecmd-0.7.6.i386-win32.msi"
$url_local64        = "http://downloads.sourceforge.net/project/doublecmd/DC%20for%20Windows%2064%20bit/Double%20Commander%200.7.6%20beta/doublecmd-0.7.6.x86_64-win64.msi?r=&ts=1480609200&use_mirror=heanet"
$url_remote64       = "https://dl.dropboxusercontent.com/u/6066664/choco/doublecmd/doublecmd-0.7.6.x86_64-win64.msi"
$url_local_trans    = ""
$url_remote_trans   = ""
$url                = ""
$url_trans          = ""
$checksum           = "d6a32e5a0cdb7cf2e2dbaf4a39c244b64f791030ec0dcf2f078ba78ddabd5d8c"
$checksum64         = "783b33864cc179dbbbcf185741c674a33f72f84c737452fdc29fc153444df6f4"
$logfile            = "$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log"
$logdir             = "$env:TEMP\chocolatey\$($packageName)"
$killexec           = 1
$killexecprocess    = "doublecmd*"
# Let's check if should we use local or remote install source
$statusCode = Test-Path $url_local
if ($statusCode) {
                    $url=$url_local
                    $url_trans=$url_local_trans
                }
    else {
        $url=$url_remote
        $url_trans=$url_remote_trans
    }
# Someone has won ;)

Start-Process -FilePath "C:\Program Files\Double Commander\unins000.exe" -ArgumentList "/SILENT"

#Let's check your TEMP derectory

$statusCode = Test-Path $logdir
if ($statusCode) {

                }
    else {
        $logfile="$env:WINDIR\TEMP\chocolatey\$($packageName).MsiInstall.log"

    }

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'msi'
  silentArgs    = "/qn /passive /norestart ADDLOCAL=ALL"
  validExitCodes= @(0, 3010, 1603, 1641)
  url           = $url
  url64bit      = $url_remote64
  checksumType  = 'sha256'
  checksumType64= 'sha256'
  checksum      = $checksum
  checksum64    = $checksum64
}

# Should we kill some exec ?
if ($killexec) {
  Stop-Process -processname $killexecprocess -force
  }

  Install-ChocolateyPackage @packageArgs

















