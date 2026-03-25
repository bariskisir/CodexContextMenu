$cli = (Get-Command codex -ErrorAction SilentlyContinue).Source
if (-not $cli) { Write-Host "Codex not found." -ForegroundColor Red; exit 1 }
$paths = @(
    "HKCU:\Software\Classes\Directory\shell\OpenInCodex"
    "HKCU:\Software\Classes\Directory\Background\shell\OpenInCodex"
)
foreach ($p in $paths) {
    $commandPath = "$p\command"
    $desiredCommand = if ($p -match "Background") { "cmd.exe /c `"cd /d `"%V`" && codex`"" } else { "cmd.exe /c `"cd /d `"%1`" && codex`"" }
    $existingCommand = (Get-ItemProperty -Path $commandPath -Name "(Default)" -ErrorAction SilentlyContinue)."(Default)"
    if ($existingCommand -eq $desiredCommand) { continue }
    New-Item -Path $commandPath -Force | Out-Null
    Set-ItemProperty -Path $p -Name "(Default)" -Value "Open in Codex"
    Set-ItemProperty -Path $p -Name "Icon" -Value "$cli,0"
    Set-ItemProperty -Path $commandPath -Name "(Default)" -Value $desiredCommand
}
Write-Host "Open in Codex added to the context menu." -ForegroundColor Green
