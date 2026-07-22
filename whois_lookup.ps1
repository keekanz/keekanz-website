try {
    $rdapUrl = "https://rdap.verisign.com/com/v1/domain/keekanz.com"
    $client = New-Object System.Net.WebClient
    $jsonStr = $client.DownloadString($rdapUrl)
    $json = $jsonStr | ConvertFrom-Json
    
    Write-Host "Domain: keekanz.com"
    foreach ($entity in $json.entities) {
        if ($entity.roles -contains "registrar") {
            Write-Host "Registrar Name: $($entity.vcardArray[1] | Where-Object { $_[0] -eq 'fn' } | ForEach-Object { $_[3] })"
        }
    }
} catch {
    Write-Host "RDAP Error: $_"
}
