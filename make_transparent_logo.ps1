Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\keekanz_logo_clean.png"
$destPath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\keekanz_logo_transparent.png"

if (Test-Path $srcPath) {
    $img = New-Object System.Drawing.Bitmap $srcPath
    $transparentBmp = New-Object System.Drawing.Bitmap $img.Width, $img.Height

    for ($y = 0; $y -lt $img.Height; $y++) {
        for ($x = 0; $x -lt $img.Width; $x++) {
            $pixel = $img.GetPixel($x, $y)
            $brightness = ($pixel.R + $pixel.G + $pixel.B) / 3
            
            if ($brightness -lt 30) {
                # Pure transparent background
                $transparentBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb(0, 0, 0, 0))
            } else {
                # Preserve crisp white / silver color with smooth alpha map
                $alpha = [int][Math]::Min(255, $brightness * 1.5)
                $transparentBmp.SetPixel($x, $y, [System.Drawing.Color]::FromArgb($alpha, 255, 255, 255))
            }
        }
    }

    $img.Dispose()
    $transparentBmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $transparentBmp.Dispose()
    Write-Host "Created high-quality transparent PNG logo at $destPath"
}
