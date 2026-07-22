$src = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\pdf_pages"
$dest = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\assets"
if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force }

Get-ChildItem -Path $src -Filter "*.jpg" | ForEach-Object {
    Copy-Item $_.FullName -Destination (Join-Path $dest $_.Name) -Force
}
Write-Host "Assets copied successfully!"
