$dirPath = "C:\Users\kkhtp\OneDrive\Desktop\260722 KEEKANZ 2.0"
$files = Get-ChildItem -Path $dirPath
foreach ($f in $files) {
    Write-Host "Name: $($f.Name) | FullName: $($f.FullName) | Size: $($f.Length)"
}
