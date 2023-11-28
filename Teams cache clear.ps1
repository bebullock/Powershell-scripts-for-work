# Closes the Teams application.
Get-Process Teams | stop-process -force

# Pause for a second and a half.
Start-Sleep -Milliseconds 1500

# Clear the Teams cache folders.
Remove-Item -path $env:APPDATA"\Microsoft\teams\Cache\*"
Remove-Item -path $env:APPDATA"\Microsoft\teams\blob_storage\*"
Remove-Item -path $env:APPDATA"\Microsoft\teams\databases\*"
Remove-Item -path $env:APPDATA"\Microsoft\teams\GPUcache\*"
Remove-Item -path $env:APPDATA"\Microsoft\teams\IndexedDB\*" -recurse
Remove-Item -path $env:APPDATA"\Microsoft\teams\Local Storage\*" -recurse
Remove-Item -path $env:APPDATA"\Microsoft\teams\tmp\*"
# Remove-Item -path $env:APPDATA"\Microsoft\teams\backgrounds\*"

# Pause for a second and a half.
Start-Sleep -Milliseconds 1500

# Restart Teams.
& $env:LOCALAPPDATA\Microsoft\Teams\Update.exe -processStart "Teams.exe"

# Log this actvity to the asset.
$whoRunAs = $env:USERNAME
Log-Activity -Message "The Microsoft Teams Cache was flushed for user: $($whoRunAs)" -EventName "MS Teams Cache Flush"