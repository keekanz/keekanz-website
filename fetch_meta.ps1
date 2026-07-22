$vimeoIds = @('257499542', '409777499', '1076621501', '632764718')

foreach ($id in $vimeoIds) {
    try {
        $url = "https://vimeo.com/api/oembed.json?url=https://vimeo.com/$id"
        $headers = @{ "User-Agent" = "Mozilla/5.0 (Windows NT 10.0; Win64; x64)" }
        $res = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
        Write-Host ("ID: " + $id + " | Title: " + $res.title)
    } catch {
        Write-Host ("Failed for " + $id + ": " + $_.Exception.Message)
    }
}
