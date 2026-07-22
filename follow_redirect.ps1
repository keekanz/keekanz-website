$req = [System.Net.HttpWebRequest]::Create("https://keekanz.com")
$req.AllowAutoRedirect = $true
$req.UserAgent = "Mozilla/5.0"
try {
    $res = $req.GetResponse()
    $sr = New-Object System.IO.StreamReader($res.GetResponseStream())
    $html = $sr.ReadToEnd()
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("Final URL: " + $res.ResponseUri.AbsoluteUri)
    Write-Host ("Title: " + $titleMatch.Groups[1].Value)
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
