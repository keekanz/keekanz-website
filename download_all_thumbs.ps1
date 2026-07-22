$vimeoIds = @(
    '367705510', '808207560', '301162175', '257499478', '257499542',
    '226622337', '66318033', '125797315', '429874851', '79064442', '183131735', '409777499',
    '1106011186', '584507509', '1106019378', '808206803', '1211607871', '632764605', '348773038', '282733951', '1076621501', '632764718',
    '1211620605', '1143740657'
)

$thumbDir = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\thumbnails"
if (-not (Test-Path $thumbDir)) { New-Item -ItemType Directory -Path $thumbDir -Force }

$client = New-Object System.Net.WebClient
$client.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")

foreach ($id in $vimeoIds) {
    $outPath = Join-Path $thumbDir "thumb_$id.jpg"
    $vumbnailUrl = "https://vumbnail.com/$id.jpg"
    
    try {
        Write-Host "Downloading thumbnail for ID $id..."
        $client.DownloadFile($vumbnailUrl, $outPath)
        $fileInfo = Get-Item $outPath
        Write-Host "Saved $outPath ($($fileInfo.Length) bytes)"
    } catch {
        Write-Host "Vumbnail failed for $id, trying oEmbed..."
        try {
            $oembedUrl = "https://vimeo.com/api/oembed.json?url=https://vimeo.com/$id"
            $jsonStr = $client.DownloadString($oembedUrl)
            $json = $jsonStr | ConvertFrom-Json
            if ($json.thumbnail_url) {
                $client.DownloadFile($json.thumbnail_url, $outPath)
                Write-Host "Saved oEmbed thumb for $id"
            }
        } catch {
            Write-Host "Failed all downloads for $id"
        }
    }
}
