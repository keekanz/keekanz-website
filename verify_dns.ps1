try {
    $a = Resolve-DnsName -Name "keekanz.com" -Type A -Server 8.8.8.8
    Write-Host "Google Public DNS A Record for keekanz.com:"
    foreach ($item in $a) {
        Write-Host "  $($item.IPAddress)"
    }
    
    $cname = Resolve-DnsName -Name "www.keekanz.com" -Type CNAME -Server 8.8.8.8
    Write-Host "Google Public DNS CNAME Record for www.keekanz.com:"
    foreach ($item in $cname) {
        Write-Host "  $($item.NameHost)"
    }
} catch {
    Write-Host "DNS Query result: $_"
}
