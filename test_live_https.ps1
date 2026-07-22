try {
    $req = [System.Net.HttpWebRequest]::Create("https://keekanz.com")
    $req.UserAgent = "Mozilla/5.0"
    $res = $req.GetResponse()
    $sr = New-Object System.IO.StreamReader($res.GetResponseStream())
    $html = $sr.ReadToEnd()
    
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host "LIVE WEBSITE TITLE: '$($titleMatch.Groups[1].Value)'"
    Write-Host "HTTP Status: $($res.StatusCode)"
} catch {
    Write-Host "Live fetch result: $_"
}
