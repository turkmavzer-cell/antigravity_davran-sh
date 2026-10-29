param(
    [string]$Message = "chore: öğrenimleri senkronize et"
)

# antigravity_davran-sh reposunu GitHub ile senkronize eder.
$ErrorActionPreference = "Continue"
$repo = Split-Path -Parent $PSScriptRoot
Set-Location $repo

git add -A
$changes = git status --porcelain
if ($changes) {
    git commit -m $Message | Out-Null
    Write-Output "Commit: $Message"
} else {
    Write-Output "Commitlenecek değişiklik yok."
}

git pull --rebase origin main 2>&1 | Write-Output
git push origin main 2>&1 | Write-Output
if ($LASTEXITCODE -ne 0) {
    Write-Output "PUSH_FAILED: Değişiklikler yerelde kaldı."
    exit 1
}
Write-Output "SYNC_OK"
