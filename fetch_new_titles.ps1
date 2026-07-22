$vimeoIds = @('257499542', '409777499', '1076621501', '632764718')

foreach ($id in $vimeoIds) {
    try {
        $url = "https://vimeo.com/api/oembed.json?url=https://vimeo.com/$id"
        $res = Invoke-RestMethod -Uri $url -Method Get
        Write-Host "Vimeo ID $id => Title: '$($res.title)', Author: '$($res.author_name)'"
    } catch {
        Write-Host "Failed to fetch for ID $id"
    }
}
