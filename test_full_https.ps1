try {
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "Mozilla/5.0")
    $html = $client.DownloadString("https://keekanz.com")
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("LIVE SITE TITLE: " + $titleMatch.Groups[1].Value)
} catch {
    Write-Host ("HTTPS Fetch Result: " + $_.Exception.Message)
}
