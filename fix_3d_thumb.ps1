$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")
try {
    $html = $client.DownloadString("https://vimeo.com/1211620605")
    $imgMatch = [regex]::Match($html, '<meta property="og:image" content="([^"]+)"')
    if ($imgMatch.Success) {
        $imgUrl = $imgMatch.Groups[1].Value.Replace('&amp;', '&')
        $client.DownloadFile($imgUrl, "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\thumbnails\thumb_1211620605.jpg")
        Write-Host "Success 1211620605"
    }
} catch {
    Write-Host "Fallback to pdf_pages slide 9"
}
