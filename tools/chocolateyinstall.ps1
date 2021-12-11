$ErrorActionPreference = 'Stop';

$packageName        = 'doublecmd'
$version            = '1.0.2'
$url                = "https://sourceforge.net/projects/doublecmd/files/DC%20for%20Windows%2032%20bit/Double%20Commander%20$version%20beta/doublecmd-$version.i386-win32.msi/download?use_mirror=autoselect"
$url64              = "https://sourceforge.net/projects/doublecmd/files/DC%20for%20Windows%2064%20bit/Double%20Commander%20$version%20beta/doublecmd-$version.x86_64-win64.msi/download?use_mirror=autoselect"
$checksum           = "6d5d36138faa72414b2dd116f34598ad3adbd2301d92191a991f4bae726ebf79"
$checksum64         = "dae5d106ee1a66f9ae0c54c279d1e543ddaf5025f57d8071ea6b19303574d5c8"
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
