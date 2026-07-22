try {
    $req = [System.Net.HttpWebRequest]::Create("https://keekanz.com")
    $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
    $req.CachePolicy = New-Object System.Net.Cache.HttpRequestCachePolicy([System.Net.Cache.HttpRequestCacheLevel]::BypassCache)
    $res = $req.GetResponse()
    $sr = New-Object System.IO.StreamReader($res.GetResponseStream())
    $html = $sr.ReadToEnd()
    
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("FULL SUCCESS! TITLE: " + $titleMatch.Groups[1].Value)
    Write-Host ("URL: " + $res.ResponseUri.AbsoluteUri)
} catch {
    Write-Host ("Fetch result: " + $_.Exception.Message)
}
