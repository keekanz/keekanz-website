$dirPath = "C:\Users\kkhtp\OneDrive\Desktop\260722 KEEKANZ 2.0"
$psdFile = Get-ChildItem -Path $dirPath -Filter "*.psd" | Select-Object -First 1
$bytes = [System.IO.File]::ReadAllBytes($psdFile.FullName)

# Search for photoshop:LayerName and photoshop:LayerText tags in UTF-8 / UTF-16
$strUtf8 = [System.Text.Encoding]::UTF8.GetString($bytes)
$matches = [regex]::Matches($strUtf8, '<photoshop:LayerName>(.*?)</photoshop:LayerName>')

$outPath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\psd_layer_names_utf8.txt"
$lines = @()
foreach ($m in $matches) {
    $lines += $m.Groups[1].Value
}

$lines | Set-Content -Path $outPath -Encoding UTF8
Write-Host "Extracted $($lines.Count) UTF-8 layer names"
