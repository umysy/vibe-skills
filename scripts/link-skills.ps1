# Links every skill folder in this repo into the harness skill directories.
# Uses directory junctions (no admin rights needed). Re-run after adding, removing, or renaming a skill.
# An existing real folder with the same name is left alone and reported, never overwritten.

$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot

$targets = @(Join-Path $env:USERPROFILE '.agents\skills')
if ($env:CLAUDE_CONFIG_DIR) {
    $targets += (Join-Path $env:CLAUDE_CONFIG_DIR 'skills')
} else {
    $targets += (Join-Path $env:USERPROFILE '.claude\skills')
}

$skills = Get-ChildItem -Path $root -Directory | Where-Object { Test-Path (Join-Path $_.FullName 'SKILL.md') }

foreach ($target in $targets) {
    if (-not (Test-Path $target)) { New-Item -ItemType Directory -Path $target | Out-Null }
    foreach ($skill in $skills) {
        $link = Join-Path $target $skill.Name
        $item = Get-Item -LiteralPath $link -Force -ErrorAction SilentlyContinue
        if ($item -and -not $item.LinkType) {
            Write-Warning "Skipped $link : a real folder already exists there."
            continue
        }
        if ($item) {
            $current = @($item.Target)[0]
            if ($current -and ((Resolve-Path -LiteralPath $current -ErrorAction SilentlyContinue).Path -eq $skill.FullName)) {
                Write-Output "Already linked $link"
                continue
            }
            Write-Warning "Replacing $link (was -> $current)"
            $item.Delete()
        }
        New-Item -ItemType Junction -Path $link -Target $skill.FullName | Out-Null
        Write-Output "Linked $link -> $($skill.FullName)"
    }
}
