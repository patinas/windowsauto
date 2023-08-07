


Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser



# Function to check internet connectivity
function Test-InternetConnection {
    param (
        [string]$RemoteAddress = "8.8.8.8",
        [int]$TimeToLive = 128
    )
    $result = Test-Connection -ComputerName $RemoteAddress -Count 1 -Quiet -TimeToLive $TimeToLive
    return $result
}

# Check if connected to the internet
if (-not (Test-InternetConnection)) {
    Write-Host "Offline. Please connect to a Wi-Fi network."

    # Ask for Wi-Fi credentials
    $wifiName = Read-Host "Enter the Wi-Fi name (SSID)"
    $wifiPassword = Read-Host "Enter the Wi-Fi password"

    # Try to connect to Wi-Fi
    try {
        netsh wlan add profile name="$wifiName" ssid="$wifiName" keyMaterial="$wifiPassword" interface="Wi-Fi"
        netsh wlan connect name="$wifiName" ssid="$wifiName" interface="Wi-Fi"
        Write-Host "Connected to Wi-Fi: $wifiName"
    } catch {
        Write-Host "Failed to connect to Wi-Fi. Please check your credentials and try again."
    }
} else {
    Write-Host "Online. No need to connect to a Wi-Fi network."
}




Install-Module PSWindowsUpdate -Force
Update-Module -Name PSWindowsUpdate -Force



# Check for Windows updates
$updates = Get-WindowsUpdate

# Install updates
$updates | Install-WindowsUpdate -AcceptAll

# Check if a system reboot is required
if ($updates | Where-Object { $_.RequiresReboot -eq $true }) {
    # Initiate an automatic system reboot
    Restart-Computer -Force
}




# Disable UAC prompt
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0




$Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
Set-ItemProperty -Path $Path -Name "HideIcons" -Value 1
Get-Process "explorer"| Stop-Process


# Function to set the taskbar button size
function Set-SmallTaskbarButtons {
    param (
        [int]$size
    )

    $Path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    $Name = "TaskbarSmallIcons"
    
    # Check if the value exists in the Registry
    if (Test-Path $Path) {
        # Set the desired size
        Set-ItemProperty -Path $Path -Name $Name -Value $size
    } else {
        # Create the path and set the value
        New-Item -Path $Path -Force | Out-Null
        Set-ItemProperty -Path $Path -Name $Name -Value $size
    }
}

# Usage: Set small taskbar buttons (0 for large, 1 for small)
Set-SmallTaskbarButtons -size 1





Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer" -Name "EnableAutoTray" -Value 0
Stop-Process -Name "Explorer"





Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install googlechrome vscode nvidia-geforce-now -y

# Check if Google Chrome is installed
$chromePath = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe').'(Default)'
if ($chromePath -eq $null) {
    Write-Host "Google Chrome is not installed or not found. Please install Google Chrome first."
    exit
}

# Set Google Chrome as the default browser in Windows registry
$defaultBrowserKey = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'
Set-ItemProperty -Path $defaultBrowserKey -Name 'Progid' -Value 'ChromeHTML' -Force

$defaultBrowserKey = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice'
Set-ItemProperty -Path $defaultBrowserKey -Name 'Progid' -Value 'ChromeHTML' -Force

Write-Host "Google Chrome has been set as the default browser."





# Check if any drivers are missing in Device Manager
$missingDrivers = Get-PnpDevice | Where-Object { $_.Status -eq "Error" }

if ($missingDrivers) {
    Write-Host "Some drivers are missing in Device Manager."

    # Install DriverEasy Free using Chocolatey (if not already installed)
    if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "Installing Chocolatey..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

    Write-Host "Installing DriverEasy Free..."
    choco install drivereasyfree -y

    # Open the DriverEasy Free application
    $driverEasyPath = (Get-Command "DriverEasy.exe" -ErrorAction SilentlyContinue).Source
    if ($driverEasyPath) {
        Write-Host "Opening DriverEasy Free..."
        Start-Process -FilePath "$driverEasyPath"
    } else {
        Write-Host "DriverEasy Free is installed, but the executable path was not found."
    }
} else {
    Write-Host "All drivers are up to date in Device Manager."
}

