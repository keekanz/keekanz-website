$dirPath = "C:\Users\kkhtp\OneDrive\Desktop\260722 KEEKANZ 2.0"
$pdfFile = Get-ChildItem -Path $dirPath -Filter "*.pdf" | Select-Object -First 1
$bytes = [System.IO.File]::ReadAllBytes($pdfFile.FullName)
$outDir = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\all_pdf_images"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force }

Write-Host "PDF size: $($bytes.Length) bytes"

$jpegStarts = @()
for ($i = 0; $i -lt ($bytes.Length - 3); $i++) {
    if ($bytes[$i] -eq 0xFF -and $bytes[$i+1] -eq 0xD8 -and $bytes[$i+2] -eq 0xFF) {
        $jpegStarts += $i
    }
}

Write-Host "Found $($jpegStarts.Count) potential JPEG streams"

$savedCount = 0
for ($k = 0; $k -lt $jpegStarts.Count; $k++) {
    $start = $jpegStarts[$k]
    $end = -1
    for ($j = $start + 2; $j -lt ($bytes.Length - 1); $j++) {
        if ($bytes[$j] -eq 0xFF -and $bytes[$j+1] -eq 0xD9) {
            $end = $j + 1
            break
        }
    }
    if ($end -gt $start) {
        $length = $end - $start + 1
        if ($length -gt 5000) { # Keep all images > 5KB
            $savedCount++
            $imgBytes = New-Object byte[] $length
            [Array]::Copy($bytes, $start, $imgBytes, 0, $length)
            $imgPath = Join-Path $outDir "img_$savedCount.jpg"
            [System.IO.File]::WriteAllBytes($imgPath, $imgBytes)
            Write-Host "Saved img $savedCount to $imgPath ($length bytes)"
        }
    }
}
