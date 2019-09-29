# -.-.-.-.-.-.-.-.-.-.-.-.-
# Find 7-Zip executable
# -.-.-.-.-.-.-.-.-.-.-.-.-

$7Zip = Get-ChildItem c:\Program* -include '7z.exe' -recurse -ea 4 | Select-Object -first 1 -expand fullname

# -.-.-.-.-.-.-.-.-.-.-.-.-
# Loop through all containers
# -.-.-.-.-.-.-.-.-.-.-.-.-

$files = Get-ChildItem -Filter *.zip
foreach ($file in $files) {

    $fileBaseName = $file.BaseName;
    # Write-Host "Files = $fileBaseName";


    # -.-.-.-.-.-.-.-.-.-.-.-.-
    # Extract desired txt file
    # -.-.-.-.-.-.-.-.-.-.-.-.-

    & $7Zip e $file "$fileBaseName\$fileBaseName.txt" -r -y
    # Write-Host "$fileBaseName.txt";

    Clear-Host

    # -.-.-.-.-.-.-.-.-.-.-.-.-
    # Decode Base64
    # -.-.-.-.-.-.-.-.-.-.-.-.-

    $base64code = (Get-Content "$fileBaseName.txt")[2]
    # Write-Host "Base64 is = $base64code";

    $browserURL = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("$base64code"))
    Write-Host "Browser url is = $browserURL";

    # -.-.-.-.-.-.-.-.-.-.-.-.-
    # Remove useless files
    # -.-.-.-.-.-.-.-.-.-.-.-.-

    Remove-Item "$fileBaseName.txt"
    # Remove-Item "$file"

    # -.-.-.-.-.-.-.-.-.-.-.-.-
    # Get the File ID from the google Drive url
    # -.-.-.-.-.-.-.-.-.-.-.-.-

    $googleDriveID = $browserURL.substring(31)
    $googleDriveID = $googleDriveID -replace ("&export=download", "")
    Write-Host "Google Drive ID = $googleDriveID";

    # -.-.-.-.-.-.-.-.-.-.-.-.-
    # Open browser with the link                        OPTIONAL
    # -.-.-.-.-.-.-.-.-.-.-.-.-

    # Start-Process "$browserURL"

    # -.-.-.-.-.-.-.-.-.-.-.-.-
    # Download via Gdrive utility
    # -.-.-.-.-.-.-.-.-.-.-.-.-

    invoke-expression "cmd /c start powershell -Command { .\gdrive.exe download $googleDriveID; Pause}"
    
    # -.-.-.-.-.-.-.-.-.-.-.-.-
    # Wait a bit so google doesnt block you
    # -.-.-.-.-.-.-.-.-.-.-.-.-
    Start-Sleep -Seconds 1.6
}

Pause