$vimeoIds = @('257499542', '409777499', '1076621501', '632764718')

foreach ($id in $vimeoIds) {
    try {
        $url = "https://vimeo.com/$id"
        $req = [System.Net.HttpWebRequest]::Create($url)
        $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
        $res = $req.GetResponse()
        $stream = $res.GetResponseStream()
        $reader = New-Object System.IO.StreamReader($stream)
        $html = $reader.ReadToEnd()
        $reader.Close()
        $res.Close()

        $titleMatch = [regex]::Match($html, '<meta property="og:title" content="([^"]+)"')
        $imgMatch = [regex]::Match($html, '<meta property="og:image" content="([^"]+)"')
        
        $titleVal = $titleMatch.Groups[1].Value
        $imgVal = $imgMatch.Groups[1].Value
        Write-Host "Vimeo ID: $id"
        Write-Host "Title: $titleVal"
        Write-Host "Image: $imgVal"
        Write-Host "-------------------"
    } catch {
        Write-Host "Failed for ID $id"
    }
}
