$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$scriptPath         = $(Split-Path $MyInvocation.MyCommand.Path)
$url_local          = "https://downloads.sourceforge.net/project/doublecmd/DC%20for%20Windows%2032%20bit/Double%20Commander%200.7.8%20beta/doublecmd-0.7.8.i386-win32.msi"
$url_remote         = "https://dl.dropboxusercontent.com/u/6066664/choco/doublecmd/doublecmd-0.7.8.i386-win32.msi"
$url_local64        = "https://downloads.sourceforge.net/project/doublecmd/DC%20for%20Windows%2064%20bit/Double%20Commander%200.7.8%20beta/doublecmd-0.7.8.x86_64-win64.msi"
$url_remote64       = "https://dl.dropboxusercontent.com/u/6066664/choco/doublecmd/doublecmd-0.7.8.x86_64-win64.msi"
$url_local_trans    = ""
$url_remote_trans   = ""
$url                = ""
$url64              = ""
$url_trans          = ""
$checksum           = "39dadffce533c34432d81b701ff6b057ccc4cef0f9d705cb975c387436e806a2"
$checksum64         = "0e96bf489ac0622cd095247909036229782ffb08e3dc146fbcef5e845837615a"
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

















