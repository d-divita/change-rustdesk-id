# Function to generate random alphanumeric string
function Get-RandomAlphanumericString {
    param (
        [int] $length = 12
    )
    return -join ((65..90) + (97..122) + (48..57) | Get-Random -Count $length | ForEach-Object {[char]$_})
}

# Function to generate random 9-digit number
function Get-Random9DigitNumber {
    return Get-Random -Minimum 100000000 -Maximum 999999999
}

function Test-RustDeskInstalled {
    $serviceExists = Get-Service -Name "RustDesk" -ErrorAction SilentlyContinue

    if (-not $serviceExists) {
        return $false
    }
    return $true
}

# Main script starts here
if (-not (Test-RustDeskInstalled)) {
    Write-Error "RustDesk is not installed or not configured properly on this system."
    Write-Information "Please install RustDesk and run this script again."
    exit
}
Write-Verbose "Stopping RustDesk service..."
Stop-Service -Name "RustDesk" -ErrorAction SilentlyContinue

$id = Get-Content C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config\RustDesk.toml | Select-Object -Index 0
Write-Output "Current ID: $id"

$hostname = hostname
Write-Output "Hostname: $hostname"

# Prompt user for new ID option
Write-Output "Choose an option for the new RustDesk ID:"
Write-Output "1. Use the hostname ($hostname)"
Write-Output "2. Use a random 9-digit number"
Write-Output "3. Enter a custom value"
$idChoice = Read-Host "Enter your choice (1-3)"

switch ($idChoice) {
    "1" { $newIdValue = $hostname }
    "2" { $newIdValue = Get-Random9DigitNumber }
    "3" { $newIdValue = Read-Host "Enter your custom RustDesk ID" }
    default {
        Write-Warning "Invalid choice. Using hostname as default."
        $newIdValue = $hostname
    }
}

$newId = "id = '$newIdValue'"
Write-Output "New ID: $newId"

$filecontent = Get-Content -Path C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config\RustDesk.toml -Raw
Write-Verbose "Current file content:"
Write-Verbose $filecontent

Write-Verbose "Replacing ID..."
$filecontent = $filecontent.Replace("$id","$newId")

$password = Get-Content C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config\RustDesk.toml | Select-Object -Index 1
Write-Verbose "Current password line: $password"

$randomPassword = Get-RandomAlphanumericString -length 16
$newPassword = "password = '$randomPassword'"
Write-Verbose "New password line: $newPassword"

Write-Verbose "Replacing password..."
$filecontent = $filecontent.Replace("$password","$newPassword")

$filecontent | Set-Content -Path C:\Windows\ServiceProfiles\LocalService\AppData\Roaming\RustDesk\config\RustDesk.toml

Write-Verbose "Final file content:"
Write-Verbose $filecontent

Write-Verbose "Starting RustDesk service..."
Start-Service -Name "RustDesk" -ErrorAction SilentlyContinue

Write-Output "RustDesk ID has been changed to: $newId"
Write-Output "RustDesk password has been changed to a random 16-character string."
Write-Output "New password: $randomPassword"
