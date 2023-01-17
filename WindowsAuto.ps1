Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

choco install notepadplusplus snappy-driver-installer-origin tailscale rufus chrome-remote-desktop-chrome chrome-remote-desktop-host microsoft-teams googlechrome 7zip vlc adobereader winrar googledrive obsidian pandoc autohotkey brave putty tabby etcher -y
choco upgrade all -y
choco feature enable -y allowGlobalConfirmation





