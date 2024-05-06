$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$version            = '1.1.14'
$url                = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.i386-win32.msi"
$url64              = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.x86_64-win64.msi"
$checksum           = 'c3064a7f71f5c62f1534b50c3aa18720e7d4ed316c6b15abe6f8e8b74153d4fe '
$checksum64         = 'c5e3e813a8211e93de5984c4dd7d0fadd7f3b42c5ee4b94e1d0c4699ca650945'
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

