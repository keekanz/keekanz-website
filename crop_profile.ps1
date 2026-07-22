Add-Type -AssemblyName System.Drawing

$slide2Path = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\pdf_pages\slide_2.jpg"
$outProfilePath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\profile_photo.png"

if (Test-Path $slide2Path) {
    $img = New-Object System.Drawing.Bitmap $slide2Path
    Write-Host "Slide 2 Size: $($img.Width) x $($img.Height)"

    # Find non-black bounding box for the profile picture on the left side
    $minX = $img.Width
    $maxX = 0
    $minY = $img.Height
    $maxY = 0

    for ($y = 0; $y -lt $img.Height; $y += 2) {
        # Profile is on the left half (x < width * 0.4)
        for ($x = 0; $x -lt ($img.Width * 0.4); $x += 2) {
            $pixel = $img.GetPixel($x, $y)
            if ($pixel.R -gt 25 -or $pixel.G -gt 25 -or $pixel.B -gt 25) {
                if ($x -lt $minX) { $minX = $x }
                if ($x -gt $maxX) { $maxX = $x }
                if ($y -lt $minY) { $minY = $y }
                if ($y -gt $maxY) { $maxY = $y }
            }
        }
    }

    Write-Host "Profile Bounding box: X=$minX..$maxX, Y=$minY..$maxY"

    $width = $maxX - $minX + 1
    $height = $maxY - $minY + 1

    # Crop square around profile
    $cropBmp = New-Object System.Drawing.Bitmap $width, $height
    $g = [System.Drawing.Graphics]::FromImage($cropBmp)
    $srcRect = New-Object System.Drawing.Rectangle $minX, $minY, $width, $height
    $destRect = New-Object System.Drawing.Rectangle 0, 0, $width, $height

    $g.DrawImage($img, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $img.Dispose()

    $cropBmp.Save($outProfilePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $cropBmp.Dispose()
    Write-Host "Saved crisp cropped profile PNG to $outProfilePath"
}
