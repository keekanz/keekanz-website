try {
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
    
    Write-Host "Testing keekanz.com..."
    $html1 = $client.DownloadString("https://keekanz.com")
    $t1 = [regex]::Match($html1, '<title>([^<]+)</title>')
    Write-Host ("keekanz.com Title: " + $t1.Groups[1].Value)
} catch {
    Write-Host ("keekanz.com error: " + $_.Exception.Message)
}

try {
    $client2 = New-Object System.Net.WebClient
    $client2.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
    Write-Host "Testing www.keekanz.com..."
    $html2 = $client2.DownloadString("https://www.keekanz.com")
    $t2 = [regex]::Match($html2, '<title>([^<]+)</title>')
    Write-Host ("www.keekanz.com Title: " + $t2.Groups[1].Value)
} catch {
    Write-Host ("www.keekanz.com error: " + $_.Exception.Message)
}
