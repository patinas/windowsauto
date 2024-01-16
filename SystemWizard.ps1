# Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser (Check execution policy manually)

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

    # Securely prompt for Wi-Fi credentials
    $wifiCredential = Get-Credential -Message "Enter Wi-Fi credentials"
    
    # Try to connect to Wi-Fi
    try {
        # Implement Wi-Fi connection logic here
        # ...
        Write-Host "Connected to Wi-Fi: $($wifiCredential.UserName)"
    } catch {
        Write-Host "Failed to connect to Wi-Fi. Please check your credentials and try again."
    }
} else {
    Write-Host "Online. No need to connect to a Wi-Fi network."
}

# Check if PSWindowsUpdate module is installed
$moduleInstalled = Get-Module -ListAvailable | Where-Object { $_.Name -eq 'PSWindowsUpdate' }

if ($moduleInstalled) {
    Write-Host "PSWindowsUpdate module is already installed."
} else {
    Write-Host "Installing PSWindowsUpdate module..."
    Install-Module PSWindowsUpdate -Force
}

# Import the PSWindowsUpdate module (if not imported already)
if (-not (Get-Module -Name PSWindowsUpdate -ListAvailable)) {
    Import-Module PSWindowsUpdate
}

# Update the PSWindowsUpdate module if necessary
Update-Module -Name PSWindowsUpdate -Force

# Check for Windows updates
$updates = Get-WindowsUpdate

if ($updates.Count -eq 0) {
    Write-Host "No new Windows updates available."
} else {
    Write-Host "Found $($updates.Count) Windows updates."

    # Install updates
    $updates | Install-WindowsUpdate -AcceptAll
}



# Define the script path and name
$scriptPath = ".\SystemWizard.ps1"

# Create a new scheduled task
$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-NoProfile -ExecutionPolicy Bypass -File $scriptPath"
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -Action $action -Trigger $trigger -TaskName "MyScriptAtStartup"



# Check if a system reboot is required
if ($updates | Where-Object { $_.RequiresReboot -eq $true }) {
    # Initiate an automatic system reboot
    Restart-Computer -Force
}

# Disable UAC prompt
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "EnableLUA" -Value 0



# Install Chocolatey and Google Chrome
# Check if Chocolatey is installed, and if not, install it
if (-not (Get-Command choco -ErrorAction SilentlyContinue)) {
    Write-Host "Installing Chocolatey..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

# Check if Google Chrome is already installed
$chromeInstalled = Test-Path "C:\Program Files\Google\Chrome\Application\chrome.exe"

if ($chromeInstalled) {
    Write-Host "Google Chrome is already installed."
} else {
    # Install Google Chrome using Chocolatey
    Write-Host "Installing Google Chrome..."
    choco install googlechrome -y

    # Check if Google Chrome is successfully installed
    $chromeInstalled = Test-Path "C:\Program Files\Google\Chrome\Application\chrome.exe"

    if ($chromeInstalled) {
        Write-Host "Google Chrome has been successfully installed."
        
        # Set Google Chrome as the default browser in Windows registry
        $defaultBrowserKey = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'
        Set-ItemProperty -Path $defaultBrowserKey -Name 'Progid' -Value 'ChromeHTML' -Force

        $defaultBrowserKey = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice'
        Set-ItemProperty -Path $defaultBrowserKey -Name 'Progid' -Value 'ChromeHTML' -Force

        Write-Host "Google Chrome has been set as the default browser."
    } else {
        Write-Host "Google Chrome installation failed. Please check Chocolatey and try again."
    }
}

# Set Google Chrome as the default browser in Windows registry
$defaultBrowserKey = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice'
Set-ItemProperty -Path $defaultBrowserKey -Name 'Progid' -Value 'ChromeHTML' -Force

$defaultBrowserKey = 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice'
Set-ItemProperty -Path $defaultBrowserKey -Name 'Progid' -Value 'ChromeHTML' -Force

Write-Host "Google Chrome has been set as the default browser."



# Check for missing drivers in Device Manager
$missingDrivers = Get-PnpDevice | Where-Object { $_.Status -eq "Error" }

if ($missingDrivers.Count -gt 0) {
    Write-Host "Some drivers are missing or have errors in Device Manager:"
    
    foreach ($driver in $missingDrivers) {
        Write-Host "Device Name: $($driver.DeviceName)"
        Write-Host "Device ID: $($driver.DeviceID)"
        Write-Host "Status: $($driver.Status)"
        Write-Host ""
    }

    # You can add logic here to handle missing drivers, such as installing them.
} else {
    Write-Host "All drivers are up to date in Device Manager."
}
