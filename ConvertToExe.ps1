Set-ExecutionPolicy Bypass -Scope Process -Force;
Install-Module ps2exe
Import-Module ps2exe
Invoke-ps2exe "C:\Users\user\Downloads\Windows Deployment-20211220T121527Z-001\Windows Deployment\Remote_Desktop_Enable.ps1" "C:\Users\user\Downloads\Windows Deployment-20211220T121527Z-001\Windows Deployment\Remote_Desktop_Enable.exe"