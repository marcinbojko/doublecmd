$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$version            = '0.8.4'
$url                = "https://sourceforge.net/projects/doublecmd/files/DC%20for%20Windows%2032%20bit/Double%20Commander%20$version%20beta/doublecmd-$version.i386-win32.msi/download?use_mirror=autoselect"
$url64              = "https://sourceforge.net/projects/doublecmd/files/DC%20for%20Windows%2064%20bit/Double%20Commander%20$version%20beta/doublecmd-$version.x86_64-win64.msi/download?use_mirror=autoselect"
$checksum           = "448ebdeb3204337ad3e5caa4481ad273d2000183501192923be8f5a898aa2d8f"
$checksum64         = "30303a3ea3697b3ef77a2d6cfab7080a56f2c26645cba816f5103618bc241e67"
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
