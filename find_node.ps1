$paths = @(
    "$env:ProgramFiles\nodejs",
    "$env:ProgramFiles(x86)\nodejs",
    "$env:APPDATA\npm",
    "$env:LOCALAPPDATA\Programs",
    "C:\Program Files\nodejs",
    "C:\ProgramFiles\nodejs"
)

foreach ($p in $paths) {
    if (Test-Path "$p\node.exe") {
        Write-Host "FOUND NODE: $p\node.exe"
    }
    if (Test-Path "$p\npx.cmd") {
        Write-Host "FOUND NPX: $p\npx.cmd"
    }
}

$whereNode = Get-Command node -ErrorAction SilentlyContinue
if ($whereNode) { Write-Host "Get-Command node: $($whereNode.Source)" }
$whereNpx = Get-Command npx -ErrorAction SilentlyContinue
if ($whereNpx) { Write-Host "Get-Command npx: $($whereNpx.Source)" }
