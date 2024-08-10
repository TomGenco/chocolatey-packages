$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$url      = 'https://github.com/ProtonMail/inbox-desktop/releases/download/1.0.6/Proton.Mail-1.0.6.Setup.exe'
$checksum = 'e1fc07a177b22dbf2c8c7123efb59ff83d3fab413dfe964704d3b0bd5c1eb5f1'

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  fileType       = 'exe'
  url            = $url

  softwareName   = 'Proton Mail'

  checksum       = $checksum
  checksumType   = 'sha256'

  silentArgs     = '-s'
  validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
