Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

choco install tailscale zerotier-one googlechrome 7zip vlc adobereader winrar googledrive sharex obsidian pandoc autohotkey powertoys mailspring brave putty tabby etcher parsec -y

choco feature enable -y allowGlobalConfirmation

# tailscale up --authkey tskey-auth-kmYWEs4CNTRL-E58dqRPnpjitN4wH1JYshiDnogxNZCqR --unattended
zerotier-cli join 0cccb752f77190cf
zerotier-cli join 0cccb752f77190cf
zerotier-cli join 0cccb752f77190cf

netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

