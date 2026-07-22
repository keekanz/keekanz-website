try {
    $gitVer = git --version
    Write-Host "Git version: $gitVer"
} catch {
    Write-Host "Git error: $_"
}
