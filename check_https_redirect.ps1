try {
    $req = [System.Net.HttpWebRequest]::Create("https://keekanz.com")
    $req.AllowAutoRedirect = $false
    $res = $req.GetResponse()
    Write-Host ("Status: " + $res.StatusCode)
    Write-Host ("Location Header: " + $res.Headers["Location"])
} catch [System.Net.WebException] {
    $res = $_.Response
    if ($res) {
        Write-Host ("Status Code: " + $res.StatusCode)
        Write-Host ("Redirect Location: " + $res.Headers["Location"])
    } else {
        Write-Host ("WebEx Error: " + $_.Exception.Message)
    }
} catch {
    Write-Host ("Error: " + $_.Exception.Message)
}
