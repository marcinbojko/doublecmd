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

### 2017-02-24 Build 0.7.8

* version 0.7.8

* SHA256 - doublecmd-0.7.8.x86_64-win64.msi - 0e96bf489ac0622cd095247909036229782ffb08e3dc146fbcef5e845837615a [https://www.virustotal.com/pl/file/0e96bf489ac0622cd095247909036229782ffb08e3dc146fbcef5e845837615a/analysis/1487956082/](https://www.virustotal.com/pl/file/0e96bf489ac0622cd095247909036229782ffb08e3dc146fbcef5e845837615a/analysis/1487956082/)
* SHA256 - doublecmd-0.7.8.i386-win32.msi - 39dadffce533c34432d81b701ff6b057ccc4cef0f9d705cb975c387436e806a2 [https://www.virustotal.com/pl/file/39dadffce533c34432d81b701ff6b057ccc4cef0f9d705cb975c387436e806a2/analysis/1487956341/](https://www.virustotal.com/pl/file/39dadffce533c34432d81b701ff6b057ccc4cef0f9d705cb975c387436e806a2/analysis/1487956341/)
* removed passive MSI install install option
* added uninstaller for 32-bit EXE installs

### 2016-12-29 Build 0.7.7

* version 0.7.7
* SHA256 - doublecmd-0.7.7.i386-win32.msi - 7bb23f53a053f7214ba365ed3bb0ad51b2b7472a4aa37c78c039b61923f7146b - [https://www.virustotal.com/en/file/7bb23f53a053f7214ba365ed3bb0ad51b2b7472a4aa37c78c039b61923f7146b/analysis/1483013311/](https://www.virustotal.com/en/file/7bb23f53a053f7214ba365ed3bb0ad51b2b7472a4aa37c78c039b61923f7146b/analysis/1483013311/)
* SHA256 - doublecmd-0.7.7.x86_64-win64.msi - 8ad27a67e1ac72c53067421950050f305f270587d327cd38e7225dfef72c8917 - [https://www.virustotal.com/en/file/8ad27a67e1ac72c53067421950050f305f270587d327cd38e7225dfef72c8917/analysis/](https://www.virustotal.com/en/file/8ad27a67e1ac72c53067421950050f305f270587d327cd38e7225dfef72c8917/analysis/)

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

