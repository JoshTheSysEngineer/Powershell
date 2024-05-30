# PowerShell Setup
My workflow for configuring my PowerShell environment.

## Application Installs
1. [Windows Terminal](https://github.com/microsoft/terminal) (admin & user accounts)
```
$progressPreference = 'silentlyContinue'
Write-Information "Downloading WinGet and its dependencies..."
Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.8.6/Microsoft.UI.Xaml.2.8.x64.appx -OutFile Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
Add-AppxPackage Microsoft.UI.Xaml.2.8.x64.appx
Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
```
3. [PowerShell 7](https://github.com/PowerShell/PowerShell) (admin & user accounts)
4. [Oh-My-Posh](https://ohmyposh.dev/docs/installation/windows) (admin & user accounts)
```
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
```
6. [SysInternals](https://learn.microsoft.com/en-us/sysinternals/downloads/sysinternals-suite) 
7. [VS Code](https://code.visualstudio.com/download)

## Configurations
1. Create `C:\HOME` directory
2. Download and install [FieraNerdFont](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.1/FiraCode.zip)
3. Configure PowerShell Profile
3.1 `notepad $profile`; if not present `New-Item -Path $profile -Type File -Force`
```
$env:Path += ";C:\Users\user\AppData\Local\Programs\oh-my-posh\bin;C:\HOME\sysinternals"
oh-my-posh init pwsh --config "C:\Users\$($env:username)\AppData\Local\Programs\oh-my-posh\themes\catppuccin_macchiato.omp.json" | Invoke-Expression
Set-Location c:\home

function home {cls && pushd "c:\home"}
function profile {notepad $PROFILE && $PROFILE}
```
4. Copy SysInternals to `C:\HOME`
5. Add `HOME` as `C:\HOME` in System Environment Variables
6. Configure PowerShell Terminal to use `FieraNerdFont`
7. [Download syntax files for Nano](https://github.com/scopatz/nanorc)
8. Copy syntax files to `C:\Program Files\Git\usr\share\nano`
9. Create Symbolix links to useful folders under `C:\home`
```
New-Item -ItemType Directory -Path c:\pwsh
New-Item -ItemType SymbolicLink -Target c:\pwsh -Path c:\home\pwsh
New-Item -ItemType Directory -Path c:\pwsh
New-Item -ItemType SymbolicLink -Target c:\git -Path c:\home\git
```
10. Install RSAT
```
Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
```
11. Configure Termianl as default console & automatically launch PowerShell 7



   
