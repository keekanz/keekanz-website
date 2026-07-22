try {
    $a = Resolve-DnsName -Name "keekanz.com" -Type A -Server 8.8.8.8
    Write-Host "Google Public DNS A Record:"
    foreach ($item in $a) {
        Write-Host "  IP: $($item.IPAddress)"
    }
} catch {
    Write-Host "DNS Query result: $_"
}
