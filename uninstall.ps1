$paths = @(
    "HKCU:\Software\Classes\Directory\shell\OpenInCodex"
    "HKCU:\Software\Classes\Directory\Background\shell\OpenInCodex"
)
foreach ($p in $paths) {
    if (Test-Path $p) {
        Remove-Item -Path $p -Recurse -Force
    }
}
Write-Host "Open in Codex removed from the context menu." -ForegroundColor Green
