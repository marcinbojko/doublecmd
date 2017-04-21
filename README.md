# Double Commander

## Description

Double Commander is a cross platform open source file manager with two panels side by side. It is inspired by Total Commander and features some new ideas.
Double Commander can be run on several platforms and operating systems. It supports 32-bit and 64-bit processors. See Supported platforms for a complete list.
See Double Commander in action in the Gallery.

## Features

* Install and uninstall via Chocolatey
* Supports 32/64-bit version

## Changelog

### 2017-04-19 Build 0.7.8 (maintainer: marcinbojko)

* version 0.7.8
* BREAKING CHANGE - automatic uninstaller for exe version
* SHA256 - doublecmd-0.7.8.x86_64-win64.msi - 0e96bf489ac0622cd095247909036229782ffb08e3dc146fbcef5e845837615a [https://www.virustotal.com/pl/file/0e96bf489ac0622cd095247909036229782ffb08e3dc146fbcef5e845837615a/analysis/1487956082/](https://www.virustotal.com/pl/file/0e96bf489ac0622cd095247909036229782ffb08e3dc146fbcef5e845837615a/analysis/1487956082/)
* SHA256 - doublecmd-0.7.8.i386-win32.msi - 39dadffce533c34432d81b701ff6b057ccc4cef0f9d705cb975c387436e806a2 [https://www.virustotal.com/pl/file/39dadffce533c34432d81b701ff6b057ccc4cef0f9d705cb975c387436e806a2/analysis/1487956341/](https://www.virustotal.com/pl/file/39dadffce533c34432d81b701ff6b057ccc4cef0f9d705cb975c387436e806a2/analysis/1487956341/)
* removed passive MSI install option
* added uninstaller for 32-bit EXE installs


## Usage

### Direct

```cmd
choco install doublecmd
```

### YAML (Foreman, puppetlabs/chocolatey module)

```yaml
doublecmd:
  ensure: latest
  uninstall_options: "--force --all-versions"
  provider: chocolatey
```

or

```yaml
doublecmd:
  ensure: latest
```
