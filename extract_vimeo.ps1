$dirPath = "C:\Users\kkhtp\OneDrive\Desktop\260722 KEEKANZ 2.0"
$pdfFile = Get-ChildItem -Path $dirPath -Filter "*.pdf" | Select-Object -First 1
$psdFile = Get-ChildItem -Path $dirPath -Filter "*.psd" | Select-Object -First 1

function Scan-File($file, $label) {
    if (-not $file) { return }
    Write-Host "[$label] Scanning $($file.Name)..."
    $bytes = [System.IO.File]::ReadAllBytes($file.FullName)
    Write-Host "[$label] Size: $($bytes.Length) bytes"

    # Search for vimeo links
    $strAscii = [System.Text.Encoding]::ASCII.GetString($bytes)
    $matches = [regex]::Matches($strAscii, 'vimeo\.com/[^\s"''\)\<\>]+')
    Write-Host "[$label] ASCII Vimeo Matches: $($matches.Count)"
    foreach ($m in $matches) {
        Write-Host "  -> $($m.Value)"
    }

    # Search for http/https URLs
    $httpMatches = [regex]::Matches($strAscii, 'https?://[^\s"''\)\<\>]+')
    Write-Host "[$label] ASCII HTTP Matches: $($httpMatches.Count)"
    foreach ($hm in $httpMatches) {
        Write-Host "  -> $($hm.Value)"
    }
}

Scan-File $pdfFile "PDF"
Scan-File $psdFile "PSD"
