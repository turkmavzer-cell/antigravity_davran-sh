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

    if ($payload.workspacePaths -and $payload.workspacePaths.Count -gt 0) {
        foreach ($ws in $payload.workspacePaths) {
            if (-not [string]::IsNullOrWhiteSpace($ws)) {
                # file:/// URI gelirse yerel yola çevir
                $cleanPath = $ws -replace '^file:///', '' -replace '/', '\'
                $cleanPath = [System.Uri]::UnescapeDataString($cleanPath)
                $projectLearningFile = Join-Path $cleanPath ".agents\learnings\PROJECT.md"
                if ((Test-Path $cleanPath) -and (-not (Test-Path $projectLearningFile))) {
                    $msgParts += "Açık proje ('$cleanPath') henüz sisteme bağlı değil (.agents/learnings/PROJECT.md bulunamadı); uygun bir anda kullanıcıya 'projeyi bağla' komutunu hatırlat."
                } elseif (Test-Path $projectLearningFile) {
                    $msgParts += "Açık proje ('$cleanPath') sisteme bağlı; göreve başlamadan önce '.agents/learnings/PROJECT.md' dosyasındaki projeye özel öğrenimleri dikkate al."
                }
            }
        }
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
