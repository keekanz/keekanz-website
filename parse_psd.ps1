$dirPath = "C:\Users\kkhtp\OneDrive\Desktop\260722 KEEKANZ 2.0"
$psdFile = Get-ChildItem -Path $dirPath -Filter "*.psd" | Select-Object -First 1

$bytes = [System.IO.File]::ReadAllBytes($psdFile.FullName)
$strAscii = [System.Text.Encoding]::ASCII.GetString($bytes)

$outPath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\psd_text_dump.txt"

# Find all occurrences of vimeo.com and extract surrounding 100 bytes
$matches = [regex]::Matches($strAscii, '.{0,50}vimeo\.com/[^\s"''\)\<\>]+.{0,50}')
$lines = @()
foreach ($m in $matches) {
    # Clean non-printable characters
    $clean = $m.Value -replace '[\x00-\x1F\x7F-\xFF]', ' '
    $lines += $clean
}

$lines | Set-Content -Path $outPath -Encoding UTF8
Write-Host "Extracted $($lines.Count) context blocks around Vimeo URLs"
