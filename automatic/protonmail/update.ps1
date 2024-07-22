import-module chocolatey-au

$releases = 'https://api.github.com/repos/ProtonMail/inbox-desktop/releases/latest'

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url_regex = '[^"]+/Proton.Mail-[^"]+.Setup.exe'
    $url = $download_page.content -match $url_regex
    $url = $matches[0]

    $version_regex = '/releases/download/v?([^/]+)/'
    $version = $url -match $version_regex
    $version = $matches[1]

    return @{ Version = $version; URL32 = $url }
}

update
