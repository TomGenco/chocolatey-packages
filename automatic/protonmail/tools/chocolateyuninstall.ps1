$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  # Cannot use just 'Proton Mail*' as softwareName, as it would conflict with the Proton Mail Bridge package when uninstalling
  softwareName  = 'Proton Mail'
  fileType      = 'exe'

  silentArgs    = '--uninstall -s'
  validExitCodes= @(0)
}

[array]$key = Get-UninstallRegistryKey -SoftwareName $packageArgs['softwareName']

if ($key.Count -eq 1) {
  $key | % {
    # Example UninstallString: "C:\Users\[USER]\AppData\Local\proton_mail\Update.exe" --uninstall
    $packageArgs['file'] = "$($_.UninstallString.Split(' -')[0].Trim('"'))"

    Uninstall-ChocolateyPackage @packageArgs
  }
} elseif ($key.Count -eq 0) {
  Write-Warning "$packageName has already been uninstalled by other means."
} elseif ($key.Count -gt 1) {
  Write-Warning "$($key.Count) matches found!"
  Write-Warning "To prevent accidental data loss, no programs will be uninstalled."
  Write-Warning "Please alert package maintainer the following keys were matched:"
  $key | % {Write-Warning "- $($_.DisplayName)"}
}