$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$version            = '1.2.0'
$url                = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.i386-win32.msi"
$url64              = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.x86_64-win64.msi"
$checksum           = '79adaf6569553e66f03aa27484b50b2136422ec04e110941044e4aadae941fa1 '
$checksum64         = '40ba692f6c08afabc19dc4a891d8a5199cbec5b4640c1fb8c32477564f2ae947'
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

