try {
    $ns = Resolve-DnsName -Name "keekanz.com" -Type NS
    Write-Host "NameServers for keekanz.com:"
    foreach ($item in $ns) {
        Write-Host "  $($item.NameHost)"
    }
    
    $a = Resolve-DnsName -Name "keekanz.com" -Type A
    Write-Host "Current A Records:"
    foreach ($item in $a) {
        Write-Host "  $($item.IPAddress)"
    }
} catch {
    Write-Host "DNS Query Error: $_"
}
