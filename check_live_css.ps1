try {
    $client = New-Object System.Net.WebClient
    $client.Headers.Add("User-Agent", "Mozilla/5.0")
    $css = $client.DownloadString("https://keekanz.com/styles.css")
    
    if ($css -match "0.82rem") {
        Write-Host "LIVE VERCEL CSS HAS THE NEW MOBILE FONT RULES (0.82rem FOUND)!"
    } else {
        Write-Host "LIVE VERCEL CSS DOES NOT HAVE NEW RULES YET (Needs Vercel upload)."
    }
} catch {
    Write-Host ("CSS Fetch Error: " + $_.Exception.Message)
}
