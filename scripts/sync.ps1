param(
    [string]$Message = "docs(learnings): öğrenimleri senkronize et"
)

# antigravity_davran-sh core reposunu GitHub ile hatasız senkronize eder (PowerShell 5.1 uyumlu).
# Git'in stderr bilgilendirme çıktılarını hata sanmamak için Continue kullanılır ve $LASTEXITCODE kontrol edilir.
$ErrorActionPreference = "Continue"
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$repo = Split-Path -Parent $PSScriptRoot
Set-Location $repo

# 1. Yerel değişiklikleri sahnele ve commit at
git add -A 2>&1 | Out-Null
$changes = git status --porcelain
if ($changes) {
    $commitOut = git commit -m $Message 2>&1
    if ($LASTEXITCODE -ne 0) {
        Write-Output "COMMIT_FAILED: $commitOut"
        exit 1
    }
    Write-Output "Commit: $Message"
} else {
    Write-Output "Commitlenecek yerel değişiklik yok."
}

# 2. Uzak repodan değişiklikleri çek (rebase ile)
$pullOut = git pull --rebase origin main 2>&1
if ($LASTEXITCODE -ne 0) {
    # Çakışma (conflict) veya rebase hatası varsa asılı kalmaması için derhal iptal et
    git rebase --abort 2>&1 | Out-Null
    Write-Output "REBASE_CONFLICT_ABORTED: Uzak repo ile çakışma tespit edildi ve 'git rebase --abort' ile geri alındı. Lütfen durumu manuel kontrol edin. Detay: $pullOut"
    exit 1
}

# 3. GitHub'a gönder (asla force push yapma)
$pushOut = git push origin main 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Output "PUSH_FAILED: Değişiklikler yerelde commitlendi ancak GitHub'a gönderilemedi. Detay: $pushOut"
    exit 1
}

Write-Output "SYNC_OK"
exit 0
