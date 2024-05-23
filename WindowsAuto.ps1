Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

# Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -value 0
# Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

choco install googlechrome tailscale parsec googledrive autohotkey sdio vscode --ignore-checksums -y
choco upgrade all -y
choco feature enable -y allowGlobalConfirmation


Set-Content "C:\Users\user\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\media.ahk" @'
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

; AutoHotkey Script to reload Bluetooth with Alt+'
; Hotkey to reload Bluetooth (Alt + ')
!'::
; Disable Bluetooth
Run, powershell -Command "Get-Service -Name bthserv | Stop-Service", , Hide
Sleep, 1000  ; Wait for 1 second
; Enable Bluetooth
Run, powershell -Command "Get-Service -Name bthserv | Start-Service", , Hide
MsgBox, Bluetooth Reloaded
return
'@

SDIO_R764.exe

Start-Process -FilePath "C:\Users\user\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\media.ahk"


# Download the desired file (replace 'https://...' with the actual URL)
$downloadUrl = 'https://raw.githubusercontent.com/patinas/windowsauto/main/KMS_VL_ALL_AIO.cmd'
Invoke-WebRequest -Uri $downloadUrl -OutFile 'C:\Users\user\Downloads\KMS_VL_ALL_AIO.cmd'  # Replace with the desired file path and extension

& 'C:\Users\user\Downloads\KMS_VL_ALL_AIO.cmd'  # Replace with the downloaded file path
