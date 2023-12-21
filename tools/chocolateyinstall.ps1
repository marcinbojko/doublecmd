$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$version            = '1.1.8'
$url                = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.i386-win32.msi"
$url64              = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.x86_64-win64.msi"
$checksum           = 'd247d83294a541ea34206951a7cc94dbcc680789679c5826fad20ac00d0f4b23 '
$checksum64         = '09f072a87db3560e21692806de68f9ef131603896eeb7cee30e3eaa9f6d9eb64'
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
Start-Sleep -s 3
Install-ChocolateyPackage @packageArgs

