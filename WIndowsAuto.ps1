# Run as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install tailscale googlechrome 7zip vlc adobereader winrar googledrive sharex obsidian pandoc autohotkey powertoys mailspring brave putty microsoft-office-deployment tabby etcher -y

choco feature enable -y allowGlobalConfirmation

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

tailscale up --authkey tskey-auth-kxhmxL5CNTRL-LYB5qBFrzJXkNSFmh9HmRXQN4GGiKLVRJ --unattended
