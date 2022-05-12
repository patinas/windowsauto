Set-ExecutionPolicy -ExecutionPolicy Unrestricted
Set-ExecutionPolicy Bypass -Scope Process -Force;
Install-Module ps2exe
Import-Module ps2exe
Invoke-ps2exe .\WindowsAuto.ps1 .\WindowsAuto.exe