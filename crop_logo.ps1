Add-Type -AssemblyName System.Drawing

$slide1Path = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\assets\slide_1.jpg"
$outLogoPath = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\assets\keekanz_logo.png"

if (Test-Path $slide1Path) {
    $img = [System.Drawing.Image]::FromFile($slide1Path)
    Write-Host "Slide 1 Image size: $($img.Width) x $($img.Height)"

    # Crop logo from middle of slide 1
    # Logo is roughly centered in slide_1.jpg
    $cropWidth = [int]($img.Width * 0.6)
    $cropHeight = [int]($img.Height * 0.4)
    $cropX = [int](($img.Width - $cropWidth) / 2)
    $cropY = [int](($img.Height - $cropHeight) / 2)

    $bmp = New-Object System.Drawing.Bitmap $cropWidth, $cropHeight
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $srcRect = New-Object System.Drawing.Rectangle $cropX, $cropY, $cropWidth, $cropHeight
    $destRect = New-Object System.Drawing.Rectangle 0, 0, $cropWidth, $cropHeight

    $g.DrawImage($img, $destRect, $srcRect, [System.Drawing.GraphicsUnit]::Pixel)
    $g.Dispose()
    $img.Dispose()

    # Save as logo PNG
    $bmp.Save($outLogoPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $bmp.Dispose()
    Write-Host "Saved logo PNG to $outLogoPath"
}
