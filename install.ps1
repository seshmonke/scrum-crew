[CmdletBinding()]
param(
    [string]$Target = ".",
    [switch]$WithScaffold
)

$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not (Test-Path $Target)) {
    New-Item -ItemType Directory -Force -Path $Target | Out-Null
}
$targetPath = (Resolve-Path $Target).Path

# 1. Skill and agents
$opencode = Join-Path $targetPath ".opencode"
New-Item -ItemType Directory -Force -Path $opencode | Out-Null
Copy-Item (Join-Path $root ".opencode\*") $opencode -Recurse -Force

Write-Host "Installed skill: $opencode\skills\scrum-crew"
Write-Host "Installed agents: $opencode\agents"

$oldSkill = Join-Path $opencode "skills\sprint-crew"
if (Test-Path $oldSkill) {
    Write-Host ""
    Write-Host "Warning: old skill found: $oldSkill"
    Write-Host "Remove it to avoid two versions of the skill."
}

# 2. Optional project scaffold, never overwrite
if ($WithScaffold) {
    $template = Join-Path $root "template"
    Get-ChildItem $template -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($template.Length).TrimStart('\', '/')
        $destination = Join-Path $targetPath $relative
        $directory = Split-Path -Parent $destination
        if (-not (Test-Path $directory)) {
            New-Item -ItemType Directory -Force -Path $directory | Out-Null
        }
        if (Test-Path $destination) {
            Write-Host "skip (exists): $relative"
        }
        else {
            Copy-Item $_.FullName $destination
            Write-Host "created: $relative"
        }
    }
}

Write-Host ""
Write-Host "Next:"
Write-Host "  cd `"$targetPath`""
Write-Host "  openspec init --tools opencode --scope project"
Write-Host "  then in OpenCode: initialize the project via scrum-crew"
