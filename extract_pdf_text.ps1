$pdfPath = "C:\Users\kkhtp\OneDrive\Desktop\260722 KEEKANZ 2.0\260722 KEEKANZ 회사소개서.pdf"
$bytes = [System.IO.File]::ReadAllBytes($pdfPath)
$ascii = [System.Text.Encoding]::ASCII.GetString($bytes)

# Search for text stream object chunks
$matches = [regex]::Matches($ascii, 'BT[\s\S]*?ET')
Write-Host "Found $($matches.Count) BT..ET text blocks"

$outPath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\pdf_text.txt"
$textOut = @()

foreach ($m in $matches) {
    $block = $m.Value
    # Extract string literals inside ( ... ) or < ... >
    $strMatches = [regex]::Matches($block, '\((.*?)\)')
    foreach ($sm in $strMatches) {
        if ($sm.Groups[1].Value.Length -gt 1) {
            $textOut += $sm.Groups[1].Value
        }
    }
}

$textOut | Set-Content -Path $outPath -Encoding UTF8
Write-Host "Saved text blocks to $outPath"
