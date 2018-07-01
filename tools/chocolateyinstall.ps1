$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
# $scriptPath         = $(Split-Path $MyInvocation.MyCommand.Path)
$url                = "https://sourceforge.net/projects/doublecmd/files/DC%20for%20Windows%2032%20bit/Double%20Commander%200.8.3%20beta/doublecmd-0.8.3.i386-win32.msi/download?use_mirror=autoselect"
$url64              = "https://sourceforge.net/projects/doublecmd/files/DC%20for%20Windows%2064%20bit/Double%20Commander%200.8.3%20beta/doublecmd-0.8.3.x86_64-win64.msi/download?use_mirror=autoselect"
$checksum           = "ebb59e339fd098951faf7652743e3129d1897f84b4eeda7b1f74956e841ca6b7"
$checksum64         = "890a370724bc5871619247590dc9bac9ec1d300cb361e404a9fab07abf21e339"
$logfile            = "$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log"
$logdir             = "$env:TEMP\chocolatey\$($packageName)"
$killexec           = 1
$killexecprocess    = "doublecmd*"

# Remove previous version installed as exe (if exist)
    $statusCode = Test-Path -Path "C:\Program Files\Double Commander\unins000.exe"
    if ($statusCode) {
        Start-Process -FilePath "C:\Program Files\Double Commander\unins000.exe" -ArgumentList "/SILENT" -ErrorAction silentlycontinue
        Start-Sleep -s 60
    }

# Remove previous version (32-bit) installed as exe (if exist)
    $statusCode = Test-Path -Path "C:\Program Files (x86)\Double Commander\unins000.exe"
    if ($statusCode) {
        Start-Process -FilePath "C:\Program Files (x86)\Double Commander\unins000.exe" -ArgumentList "/SILENT" -ErrorAction silentlycontinue
        Start-Sleep -s 60
    }

#Let's check your TEMP derectory
    $statusCode = Test-Path $logdir
    if ($statusCode) {
        $logfile = "$env:TEMP\chocolatey\$($packageName)\$($packageName).MsiInstall.log"
    }
    else {
        $logfile = "$env:WINDIR\TEMP\chocolatey\$($packageName).MsiInstall.log"

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
