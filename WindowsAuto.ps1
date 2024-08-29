Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

# Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
# Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

choco install googlechrome tailscale parsec googledrive autohotkey sdio vscode winrar --ignore-checksums -y
choco upgrade all -y
choco feature enable -y allowGlobalConfirmation


Set-Content "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\media.ahk" @'
$PgUp::
Run, explorer.exe
Return

!w::
Run, chrome.exe
Return

!s::WinMinimize, A

!q::
WinClose, A
Return

$PgDn::
Run, shutdown /s /f
Return
'@

SDIO_R764.exe

Start-Process -FilePath "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\media.ahk"


# Download the desired file (replace 'https://...' with the actual URL)
$downloadUrl = 'https://raw.githubusercontent.com/patinas/windowsauto/main/KMS_VL_ALL_AIO.cmd'
Invoke-WebRequest -Uri $downloadUrl -OutFile '$env:USERPROFILE\Downloads\KMS_VL_ALL_AIO.cmd'  # Replace with the desired file path and extension

& '$env:USERPROFILE\Downloads\KMS_VL_ALL_AIO.cmd'  # Replace with the downloaded file path
