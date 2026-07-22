$req = [System.Net.HttpWebRequest]::Create("https://www.keekanz.com")
$req.UserAgent = "Mozilla/5.0"
try {
    $res = $req.GetResponse()
    $sr = New-Object System.IO.StreamReader($res.GetResponseStream())
    $html = $sr.ReadToEnd()
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("LIVE www.keekanz.com TITLE: " + $titleMatch.Groups[1].Value)
    Write-Host ("HTTP Status: " + $res.StatusCode)
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
