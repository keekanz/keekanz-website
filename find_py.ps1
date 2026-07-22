$py = Get-ChildItem -Path "C:\Users\kkhtp\AppData\Local\Programs\ComfyUI" -Filter "python.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
if ($py) {
    Write-Host "Found Python in ComfyUI: $($py.FullName)"
    & $py.FullName -c "import sys; print(sys.version)"
} else {
    Write-Host "Python not found in ComfyUI"
}
