$port = 3000
$prefix = "http://localhost:$port/"
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)

$root = "C:\Users\kkhtp\.gemini\antigravity\scratch\keekanz-website"

try {
    $listener.Start()
    Write-Host "Server started at $prefix"
    
    # Auto open browser
    Start-Process $prefix

    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response
        
        $urlPath = $request.Url.LocalPath
        if ($urlPath -eq "/") { $urlPath = "/index.html" }
        
        $localPath = Join-Path $root ($urlPath.TrimStart('/').Replace('/', '\'))
        
        if (Test-Path $localPath -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($localPath)
            
            $ext = [System.IO.Path]::GetExtension($localPath).ToLower()
            switch ($ext) {
                ".html" { $response.ContentType = "text/html; charset=utf-8" }
                ".css"  { $response.ContentType = "text/css" }
                ".js"   { $response.ContentType = "application/javascript" }
                ".jpg"  { $response.ContentType = "image/jpeg" }
                ".png"  { $response.ContentType = "image/png" }
                ".svg"  { $response.ContentType = "image/svg+xml" }
                ".pdf"  { $response.ContentType = "application/pdf" }
                default { $response.ContentType = "application/octet-stream" }
            }
            
            $response.ContentLength64 = $bytes.Length
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
        }
        $response.OutputStream.Close()
    }
} catch {
    Write-Host "Server stopped or error: $_"
} finally {
    $listener.Stop()
}
