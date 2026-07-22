try {
    $req = [System.Net.HttpWebRequest]::Create("https://keekanz.com")
    $req.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    $res = $req.GetResponse()
    $sr = New-Object System.IO.StreamReader($res.GetResponseStream())
    $html = $sr.ReadToEnd()
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("keekanz.com LIVE TITLE: " + $titleMatch.Groups[1].Value)
} catch {
    Write-Host ("keekanz.com Error: " + $_.Exception.Message)
}

try {
    $req2 = [System.Net.HttpWebRequest]::Create("https://www.keekanz.com")
    $req2.UserAgent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"
    $res2 = $req2.GetResponse()
    $sr2 = New-Object System.IO.StreamReader($res2.GetResponseStream())
    $html2 = $sr2.ReadToEnd()
    $titleMatch2 = [regex]::Match($html2, '<title>([^<]+)</title>')
    Write-Host ("www.keekanz.com LIVE TITLE: " + $titleMatch2.Groups[1].Value)
} catch {
    Write-Host ("www.keekanz.com Error: " + $_.Exception.Message)
}
