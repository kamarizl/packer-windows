Write-Output "Installing Virtualbox Guest Additions"
Write-Output "Checking for Certificates in vBox ISO"
Get-ChildItem E:\cert -Filter *.cer | ForEach-Object { certutil -addstore -f "TrustedPublisher" $_.FullName }
Start-Process -FilePath "E:\VBoxWindowsAdditions.exe" -ArgumentList "/S" -Wait