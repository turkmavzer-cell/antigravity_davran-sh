# SessionStart Hook: Yeni sohbette aktif modeli ve açık projenin bağlantı durumunu ajana bildirir.
$ErrorActionPreference = "SilentlyContinue"
[Console]::InputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

try {
    $rawInput = [Console]::In.ReadToEnd()
    if ([string]::IsNullOrWhiteSpace($rawInput)) {
        Write-Output "{}"
        exit 0
    }

    $payload = $rawInput | ConvertFrom-Json
    $modelName = if ($payload.modelName) { [string]$payload.modelName } else { "bilinmiyor" }

    $msgParts = @()
    $msgParts += "[antigravity_davran-sh v2.0.0] Oturum başlangıç modeli: '$modelName'. İş gerektiren görevlerde mevcut model 1. önerilen model olsa bile (Uygun) kota/limit kontrolü için ASLA onay adımını atlama; öneri kutusunu (1. öneri + 2. yedek model) göster ve 'devam et' onayı bekle."

    $cleanWorkspaces = @()
    if ($payload.workspacePaths -and $payload.workspacePaths.Count -gt 0) {
        foreach ($ws in $payload.workspacePaths) {
            if (-not [string]::IsNullOrWhiteSpace($ws)) {
                $cleanPath = $ws -replace '^file:///', '' -replace '/', '\'
                $cleanPath = [System.Uri]::UnescapeDataString($cleanPath)
                if ($cleanPath -match '^[a-z]:\\') {
                    $cleanPath = $cleanPath.Substring(0,1).ToUpper() + $cleanPath.Substring(1)
                }
                $cleanWorkspaces += $cleanPath
                $projectLearningFile = Join-Path $cleanPath ".agents\learnings\PROJECT.md"
                if ((Test-Path $cleanPath) -and (-not (Test-Path $projectLearningFile))) {
                    $msgParts += "Açık proje ('$cleanPath') henüz sisteme bağlı değil (.agents/learnings/PROJECT.md bulunamadı); uygun bir anda kullanıcıya 'projeyi bağla' komutunu hatırlat."
                } elseif (Test-Path $projectLearningFile) {
                    $msgParts += "Açık proje ('$cleanPath') sisteme bağlı; göreve başlamadan önce '.agents/learnings/PROJECT.md' dosyasındaki projeye özel öğrenimleri dikkate al."
                }
            }
        }
    }

    $hasKedihane = ($cleanWorkspaces | Where-Object { $_ -match 'kedihane' }).Count -gt 0
    $otherRepos = @($cleanWorkspaces | Where-Object { $_ -notmatch 'kedihane' })
    if ($hasKedihane -and $otherRepos.Count -gt 0) {
        $targetList = $otherRepos -join ", "
        $msgParts += "OTOMATİK ÇİFT REPO MODU AKTİF: Bu projede her yeni sohbette kullanıcıdan tekrar açıklama veya 'ekip:' komutu beklemeden otomatik olarak 'kedihane' reposu yönetiminde (Tekir şefliğinde) '$targetList' reposu yönetilir. Onaydan ('devam et') hemen sonra her iki reponun AGENTS.md ve .agents/learnings/PROJECT.md kurallarını okuyarak doğrudan görevi yürüt."
    } elseif ($cleanWorkspaces.Count -eq 0 -and (Test-Path "C:\Users\dell\.gemini\antigravity\scratch\AGENTS.md")) {
        $msgParts += "VARSAYILAN ORTAK PROJE MODU: Aktif tekil workspace seçili değilse 'C:\Users\dell\.gemini\antigravity\scratch\AGENTS.md' kuralları geçerlidir; kullanıcı tekrar anlatmadan otomatik olarak 'kedihane' reposu yönetiminde (Tekir şefliğinde) 'AB-Aycam-SosyalMedyaYonetimi' ('E:\ab ayçam\AB-Aycam-SosyalMedyaYonetimi' ve 'E:\ab ayçam\github-guncelleme') reposu kullanılır."
    }

    $fullMessage = $msgParts -join " "
    $response = @{
        injectSteps = @(
            @{
                systemMessage = @{
                    systemMessage = $fullMessage
                }
            }
        )
    }

    $jsonOut = $response | ConvertTo-Json -Depth 6 -Compress
    Write-Output $jsonOut
} catch {
    Write-Output "{}"
}
exit 0