Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install zerotier-one googlechrome teamviewer 7zip vlc adobereader winrar googledrive sharex obsidian pandoc autohotkey powertoys mailspring nuclear -y

choco feature enable -y allowGlobalConfirmation

choco install zerotier-one -y

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$destination = "C:\Program Files (x86)\ZeroTier\One\zerotier-cli.bat";
Start-Process -FilePath $destination -ArgumentList "join 9f77fc393e977c16" -Wait
$exitCode = $LASTEXITCODE
Write-Verbose "Exit code was $exitCode"
$validExitCodes = @(0, 1605, 1614, 1641, 3010)
if ($validExitCodes -contains $exitCode) {
Exit 0
}
Exit $exitCode
