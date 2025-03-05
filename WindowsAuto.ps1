# Set the execution policy to bypass for the current process
Set-ExecutionPolicy Bypass -Scope Process -Force

# Update the security protocol to use TLS 1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072

# Install Chocolatey
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Allow ICMP echo requests (ping)
netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol=icmpv4:8,any dir=in action=allow

# Enable Remote Desktop
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# Install necessary software with Chocolatey
choco install googlechrome tailscale googledrive autohotkey winrar --ignore-checksums -y
choco upgrade all -y
choco feature enable -n allowGlobalConfirmation

# Create an AutoHotkey script to launch specific programs and actions
$ahkScriptPath = "$($Env:USERPROFILE)\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\media.ahk"
Set-Content -Path $ahkScriptPath -Value @'
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

# Start the AutoHotkey script at startup
Start-Process -FilePath $ahkScriptPath


# Download a file from a URL
$downloadUrl = 'https://raw.githubusercontent.com/patinas/windowsauto/main/KMS_VL_ALL_AIO.cmd'
$destinationPath = "$($Env:USERPROFILE)\Downloads\KMS_VL_ALL_AIO.cmd"
Invoke-WebRequest -Uri $downloadUrl -OutFile $destinationPath

# Execute the downloaded file
if (Test-Path $destinationPath) {
    & $destinationPath
}
