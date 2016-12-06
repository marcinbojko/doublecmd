# Double Commander

## Description

Double Commander is a cross platform open source file manager with two panels side by side. It is inspired by Total Commander and features some new ideas.
Double Commander can be run on several platforms and operating systems. It supports 32-bit and 64-bit processors. See Supported platforms for a complete list.
See Double Commander in action in the Gallery.

## Features

* Install and uninstall via Chocolatey
* Requires source path to MyGet
* Supports 32/64-bit version

## Changelog

### 2016-12-06 Build 0.7.6 (b)

* rebuild package with previous version uninstall

### 2016-12-01 Build 0.7.6

* initial build
* version 0.7.6
* SHA256 - doublecmd-0.7.6.i386-win32.msi   - d6a32e5a0cdb7cf2e2dbaf4a39c244b64f791030ec0dcf2f078ba78ddabd5d8c - [https://www.virustotal.com/en/file/d6a32e5a0cdb7cf2e2dbaf4a39c244b64f791030ec0dcf2f078ba78ddabd5d8c/analysis/1480608856/](https://www.virustotal.com/en/file/d6a32e5a0cdb7cf2e2dbaf4a39c244b64f791030ec0dcf2f078ba78ddabd5d8c/analysis/1480608856/)
* SHA256 - doublecmd-0.7.6.x86_64-win64.msi - 783b33864cc179dbbbcf185741c674a33f72f84c737452fdc29fc153444df6f4 - [https://www.virustotal.com/en/file/783b33864cc179dbbbcf185741c674a33f72f84c737452fdc29fc153444df6f4/analysis/1480608976/](https://www.virustotal.com/en/file/783b33864cc179dbbbcf185741c674a33f72f84c737452fdc29fc153444df6f4/analysis/1480608976/)

## Usage

### Direct

```cmd
choco install doublecmd -source https://www.myget.org/F/public-choco/
```

or with added source

```cmd
choco source add -n=public-choco -s"https://www.myget.org/F/public-choco" --priority=10
choco install doublecmd
```

### YAML

```yaml
doublecmd:
  ensure: latest
  uninstall_options: "--force --all-versions"
  provider: chocolatey
  source: https://www.myget.org/F/public-choco/
```

or

```yaml
doublecmd:
  ensure: latest
```

