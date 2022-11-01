# Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install zerotier-one googlechrome teamviewer 7zip vlc adobereader winrar googledrive sharex obsidian -y

choco feature enable -y allowGlobalConfirmation

choco install zerotier-one -y

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

zerotier-cli join 9f77fc393e977c16



