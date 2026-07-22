try {
    $req = [System.Net.HttpWebRequest]::Create("https://keekanz-website.vercel.app")
    $res = $req.GetResponse()
    $sr = New-Object System.IO.StreamReader($res.GetResponseStream())
    $html = $sr.ReadToEnd()
    $titleMatch = [regex]::Match($html, '<title>([^<]+)</title>')
    Write-Host ("VERCEL APP TITLE: " + $titleMatch.Groups[1].Value)
    Write-Host ("VERCEL STATUS: " + $res.StatusCode)
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
