Function Get-Networks {
    # Get Network Interfaces
    $Network = Get-WmiObject Win32_NetworkAdapterConfiguration | Where-Object { $_.MACAddress -notlike $null } | Select-Object Index, Description, IPAddress, DefaultIPGateway, MACAddress | Format-Table Index, Description, IPAddress, DefaultIPGateway, MACAddress

    # Get Wifi SSIDs and Passwords	
    $WLANProfileNames = @()

    # Get all the WLAN profile names
    $Output = netsh.exe wlan show profiles | Select-String -Pattern " : "

    # Trim the output to receive only the name
    Foreach ($WLANProfileName in $Output) {
        $WLANProfileNames += (($WLANProfileName -split ":")[1]).Trim()
    }
    $WLANProfileObjects = @()

    # Bind the WLAN profile names and also the password to a custom object
    Foreach ($WLANProfileName in $WLANProfileNames) {
        # Get the output for the specified profile name and trim the output to receive the password
        # If there is no password, it will inform the user
        try {
            $WLANProfilePassword = (((netsh.exe wlan show profiles name="$WLANProfileName" key=clear | Select-String -Pattern "Key Content") -split ":")[1]).Trim()
        } Catch {
            $WLANProfilePassword = "The password is not stored in this profile"
        }

        # Build the object and add this to an array
        $WLANProfileObject = New-Object PSCustomobject
        $WLANProfileObject | Add-Member -Type NoteProperty -Name "ProfileName" -Value $WLANProfileName
        $WLANProfileObject | Add-Member -Type NoteProperty -Name "ProfilePassword" -Value $WLANProfilePassword
        $WLANProfileObjects += $WLANProfileObject
        Remove-Variable WLANProfileObject
    }
    return $WLANProfileObjects
}

$Networks = Get-Networks

function TrimmedNetworks {
    foreach ($network in $Networks) {
        Write-Output "$($network.ProfileName): $($network.ProfilePassword)"
    }
}

$TrimmedNetworksString = TrimmedNetworks

$desktopPath = [Environment]::GetFolderPath("Desktop")
$input = $TrimmedNetworksString

$textContent = $input

$fileName = "WifiPass.txt"
$filePath = Join-Path -Path $desktopPath -ChildPath $fileName

# Create the file with the correct file type
New-Item -Path $filePath -ItemType "file"

# Set the content of the file
Set-Content -Path $filePath -Value $textContent

Start-Process "$filePath"
