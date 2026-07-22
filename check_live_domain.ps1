try {
    $ns = Resolve-DnsName -Name "keekanz.com" -Type NS -Server 8.8.8.8
    Write-Host "Google Public DNS NS Records:"
    foreach ($item in $ns) {
        Write-Host "  NS: $($item.NameHost)"
    }

    $a = Resolve-DnsName -Name "keekanz.com" -Type A -Server 8.8.8.8
    Write-Host "A Record:"
    foreach ($item in $a) {
        Write-Host "  IP: $($item.IPAddress)"
    }

    $http = [System.Net.HttpWebRequest]::Create("http://keekanz.com")
    $http.Timeout = 5000
    $res = $http.GetResponse()
    Write-Host "HTTP Response: $($res.StatusCode)"
} catch {
    Write-Host "DNS Query / HTTP Status: $_"
}
