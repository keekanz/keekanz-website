Add-Type -AssemblyName System.Drawing

$slide1Path = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\pdf_pages\slide_1.jpg"
$outLogoPath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\keekanz_logo_clean.png"

if (Test-Path $slide1Path) {
    $img = New-Object System.Drawing.Bitmap $slide1Path
    Write-Host "Slide 1 Size: $($img.Width) x $($img.Height)"

    $minX = $img.Width
    $maxX = 0
    $minY = $img.Height
    $maxY = 0

    for ($y = 0; $y -lt $img.Height; $y += 2) {
        for ($x = 0; $x -lt $img.Width; $x += 2) {
            $pixel = $img.GetPixel($x, $y)
            if ($pixel.R -gt 25 -or $pixel.G -gt 25 -or $pixel.B -gt 25) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }

    Write-Host "Bounding box: X=$minX..$maxX, Y=$minY..$maxY"

    $pad = 20
    $minX = [Math]::Max(0, $minX - $pad)
    $minY = [Math]::Max(0, $minY - $pad)
    $maxX = [Math]::Min($img.Width - 1, $maxX + $pad)
    $maxY = [Math]::Min($img.Height - 1, $maxY + $pad)

    $width = $maxX - $minX + 1
    $height = $maxY - $minY + 1

    $cropBmp = New-Object System.Drawing.Bitmap $width, $height
    $g = [System.Drawing.Graphics]::FromImage($cropBmp)
    $srcRect = New-Object System.Drawing.Rectangle $minX, $minY, $width, $height
    $destRect = New-Object System.Drawing.Rectangle 0, 0, $width, $height

    $g.DrawImage($img, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $img.Dispose()

    $cropBmp.Save($outLogoPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $cropBmp.Dispose()
    Write-Host "Saved logo PNG to $outLogoPath"
} else {
    Write-Host "slide_1.jpg not found at $slide1Path"
}
