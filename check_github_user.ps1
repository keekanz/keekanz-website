try {
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "Mozilla/5.0")
    $jsonStr = $client.DownloadString("https://api.github.com/users/keekanz")
    $json = $jsonStr | ConvertFrom-Json
    Write-Host "FOUND GITHUB USER: $($json.login)"
    Write-Host "HTML URL: $($json.html_url)"
} catch {
    Write-Host "GitHub User lookup error: $_"
}
