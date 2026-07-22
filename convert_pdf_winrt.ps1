[void][Windows.Storage.StorageFile, Windows.Storage, ContentType = WindowsRuntime]
[void][Windows.Data.Pdf.PdfDocument, Windows.Data.Pdf, ContentType = WindowsRuntime]
[void][Windows.Storage.Streams.InMemoryRandomAccessStream, Windows.Storage.Streams, ContentType = WindowsRuntime]
[System.Reflection.Assembly]::LoadWithPartialName("System.Runtime.WindowsRuntime") | Out-Null

$dirPath = "C:\Users\kkhtp\OneDrive\Desktop\260722 KEEKANZ 2.0"
$pdfFile = Get-ChildItem -Path $dirPath -Filter "*.pdf" | Select-Object -First 1

$outDir = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website\pdf_pages"
if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force }

try {
    $async1 = [Windows.Storage.StorageFile]::GetFileFromPathAsync($pdfFile.FullName)
    $task1 = [System.WindowsRuntimeSystemExtensions]::AsTask($async1)
    $task1.Wait()
    $file = $task1.Result

    $async2 = [Windows.Data.Pdf.PdfDocument]::LoadFromFileAsync($file)
    $task2 = [System.WindowsRuntimeSystemExtensions]::AsTask($async2)
    $task2.Wait()
    $pdfDoc = $task2.Result

    Write-Host "SUCCESS! Total Pages: $($pdfDoc.PageCount)"

    Add-Type -AssemblyName System.Drawing

    for ($i = 0; $i -lt $pdfDoc.PageCount; $i++) {
        $page = $pdfDoc.GetPage($i)
        $stream = New-Object Windows.Storage.Streams.InMemoryRandomAccessStream
        
        $async3 = $page.RenderToStreamAsync($stream)
        $task3 = [System.WindowsRuntimeSystemExtensions]::AsTask($async3)
        $task3.Wait()
        
        $netStream = $stream.AsStreamForRead()
        $img = [System.Drawing.Image]::FromStream($netStream)
        $outPath = Join-Path $outDir "page_$($i+1).png"
        $img.Save($outPath, [System.Drawing.Imaging.ImageFormat]::Png)
        $img.Dispose()
        $netStream.Dispose()
        $stream.Dispose()
        $page.Dispose()
        Write-Host "Saved page $($i+1) to $outPath"
    }
} catch {
    Write-Host "Error: $_"
    Write-Host $_.ScriptStackTrace
}
