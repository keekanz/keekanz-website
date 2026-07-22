try {
    $a1 = Resolve-DnsName -Name "keekanz.com" -Type A -Server ns.gabia.net
    Write-Host "Gabia NS A Record for keekanz.com:"
    foreach ($item in $a1) {
        Write-Host "  IP: $($item.IPAddress)"
    }

    $a2 = Resolve-DnsName -Name "www.keekanz.com" -Type CNAME -Server ns.gabia.net
    Write-Host "Gabia NS CNAME Record for www.keekanz.com:"
    foreach ($item in $a2) {
        Write-Host "  Host: $($item.NameHost)"
    }
} catch {
    Write-Host "Gabia Query error: $_"
}
