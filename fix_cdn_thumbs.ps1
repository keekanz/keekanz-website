$idsToFix = @('257499542', '409777499', '1106019378', '1211607871', '1076621501', '1211620605')

$thumbDir = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\thumbnails"
$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36")

foreach ($id in $idsToFix) {
    try {
        $url = "https://vimeo.com/$id"
        $html = $client.DownloadString($url)
        $imgMatch = [regex]::Match($html, '<meta property="og:image" content="([^"]+)"')
        if ($imgMatch.Success) {
            $imgUrl = $imgMatch.Groups[1].Value.Replace('&amp;', '&')
            $outPath = Join-Path $thumbDir "thumb_$id.jpg"
            $client.DownloadFile($imgUrl, $outPath)
            $f = Get-Item $outPath
            Write-Host ("SUCCESS for " + $id + ": " + $f.Length + " bytes | URL: " + $imgUrl)
        }
    } catch {
        Write-Host ("Failed fetching og:image for ID " + $id)
    }
}
