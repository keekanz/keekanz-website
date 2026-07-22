try {
    $req = [System.Net.HttpWebRequest]::Create("http://keekanz.com")
    $req.AllowAutoRedirect = $false
    $res = $req.GetResponse()
    Write-Host ("Status: " + $res.StatusCode)
    Write-Host ("Location: " + $res.Headers["Location"])
} catch [System.Net.WebException] {
    $res = $_.Response
    Write-Host ("WebEx Status: " + $res.StatusCode)
    Write-Host ("Location Header: " + $res.Headers["Location"])
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
