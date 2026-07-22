try {
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
    $html = $client.DownloadString("https://keekanz.com")
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("EXACT PAGE TITLE SERVED AT https://keekanz.com:")
    Write-Host ("  Title: " + $titleMatch.Groups[1].Value)
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
