# Double Commander

## Description

Double Commander is a cross-platform open source file manager with two panels side by side. It is inspired by Total Commander and features some new ideas.
Double Commander can be run on several platforms and operating systems. It supports 32-bit and 64-bit processors. See Supported platforms for a complete list.
See Double Commander in action in the Gallery.

## Features

* Install and uninstall via Chocolatey
* Supports 32/64-bit version

## Usage

### Direct

```cmd
choco install doublecmd -y
```

### YAML (Foreman, puppetlabs/chocolatey module)

```yaml
doublecmd:
  ensure: latest
  provider: chocolatey
```

or

```yaml
doublecmd:
  ensure: latest
```
