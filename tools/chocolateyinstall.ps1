$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$scriptPath         = $(Split-Path $MyInvocation.MyCommand.Path)
$url_local          = "https://netcologne.dl.sourceforge.net/project/doublecmd/DC%20for%20Windows%2032%20bit/Double%20Commander%200.8.0%20beta/doublecmd-0.8.0.i386-win32.msi"
$url_remote         = "https://downloads.sourceforge.net/project/doublecmd/DC%20for%20Windows%2032%20bit/Double%20Commander%200.8.0%20beta/doublecmd-0.8.0.i386-win32.msi"
$url_local64        = "https://netcologne.dl.sourceforge.net/project/doublecmd/DC%20for%20Windows%2064%20bit/Double%20Commander%200.8.0%20beta/doublecmd-0.8.0.x86_64-win64.msi"
$url_remote64       = "https://downloads.sourceforge.net/project/doublecmd/DC%20for%20Windows%2064%20bit/Double%20Commander%200.8.0%20beta/doublecmd-0.8.0.x86_64-win64.msi"
$url_local_trans    = ""
$url_remote_trans   = ""
$url                = ""
$url64              = ""
$url_trans          = ""
$checksum           = "c05a7baa5df2234ee0a52ef89a551dbd68c3299357e3ec586a53fc92f6f89288"
$checksum64         = "344bcdc4bc7d64a2528a46013ad65886650e5f0f526d030c6602e8b0467944c9"
$logfile            = "$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log"
$logdir             = "$env:TEMP\chocolatey\$($packageName)"
$killexec           = 1
$killexecprocess    = "doublecmd*"
# Let's check if should we use local or remote install source
$statusCode = Test-Path $url_local
if ($statusCode) {
                    $url=$url_local
                    $url64=$url_local64
                    $url_trans=$url_local_trans
                }
    else {
        $url=$url_remote
        $url64=$url_remote64
        $url_trans=$url_remote_trans
    }


# Someone has won ;)

# Remove previous version
$statusCode = Test-Path -Path "C:\Program Files\Double Commander\unins000.exe"
    if ($statusCode) {
        Start-Process -FilePath "C:\Program Files\Double Commander\unins000.exe" -ArgumentList "/SILENT" -ErrorAction silentlycontinue
        Start-Sleep -s 60
    }

# Remove previous version (32-bit)
$statusCode = Test-Path -Path "C:\Program Files (x86)\Double Commander\unins000.exe"
    if ($statusCode) {
        Start-Process -FilePath "C:\Program Files (x86)\Double Commander\unins000.exe" -ArgumentList "/SILENT" -ErrorAction silentlycontinue
        Start-Sleep -s 60
    }

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
  silentArgs    = "/qn /norestart ADDLOCAL=ALL"
  validExitCodes= @(0, 3010, 1603, 1641)
  url           = $url
  url64bit      = $url64
  checksumType  = 'sha256'
  checksumType64= 'sha256'
  checksum      = $checksum
  checksum64    = $checksum64
}

# Should we kill some exec ?
if ($killexec) {
  Stop-Process -processname $killexecprocess -force
  }
  Start-Sleep -s 10
  Install-ChocolateyPackage @packageArgs

















