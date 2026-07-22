try {
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "Mozilla/5.0")
    $html = $client.DownloadString("https://keekanz.com")
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("HTTPS SUCCESS! Title: " + $titleMatch.Groups[1].Value)
} catch {
    Write-Host ("SSL / DNS Status: " + $_.Exception.Message)
}
