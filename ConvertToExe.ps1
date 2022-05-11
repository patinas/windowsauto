Set-ExecutionPolicy Bypass -Scope Process -Force;
Install-Module ps2exe
Import-Module ps2exe
Invoke-ps2exe .\Remote_Desktop_Enable.ps1 .\Remote_Desktop_Enable.exe
