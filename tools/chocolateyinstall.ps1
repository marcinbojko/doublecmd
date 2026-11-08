$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$version            = '1.2.11'
$url                = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.i386-win32.msi"
$url64              = "https://github.com/doublecmd/doublecmd/releases/download/v$version/doublecmd-$version.x86_64-win64.msi"
$checksum           = 'dade60d0f553f460b48fb2543a9d672d3c48ed9bfc886b6463eefd50b91180d6 '
$checksum64         = '1e78d98898cbbc6355de40462cc800cf755ce90326d1b01094463e65ca3a33ee'
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

