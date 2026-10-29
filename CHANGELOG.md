# Değişiklik Günlüğü (`CHANGELOG.md`)

## 2.0.0 - 2026-10-29
- **Kota/Limit Dostu Onay Protokolü:** Seçili model zaten 1. önerilen model olsa bile (`✅ Uygun`), kullanıcının kalan kullanım limitini kontrol edebilmesi için onay bekleme adımı zorunlu hale getirildi.
- **Çift Kademeli Model Önerisi:** Öneri kutusuna **📏 Tahmini kapsam & kota yükü** ve **🔄 2. Yedek (limit dostu) alternatif** satırları eklendi; eşleme tablosundaki tüm görev türlerine 2. yedek model tanımlandı.
- **Alt Ajan (Subagent) Kota Tasarrufu:** Ana model Opus 5.5, Sonnet 5.5 veya Gemini 4 Argon iken rutin arama/tarama işlerinin `flash` / `flash_lite` alt ajanlarına devredilmesi kuralı eklendi.
- **3 Katmanlı Hafıza Mimarisi:**
  - Katman 1: `learnings/model-routing.md` (`override`, `düzeltme`, `onay`, `kota-gecisi` ve `🔒 Doğrulandı` ayrımı ile).
  - Katman 2: `learnings/user-preferences.md` (tüm projelerde geçerli kişisel tercihler).
  - Katman 3: `<proje>/.agents/learnings/PROJECT.md` (projeye özel öğrenimler ve `sor` varsayılan commit politikası).
- **Lifecycle Hooks (`hooks.json`):**
  - `SessionStart` (`scripts/session-start.ps1`): Oturum başında aktif modeli ve açık projenin bağlantı durumunu ajana enjekte eder.
  - `PostToolUse` (`scripts/learning-autosync.ps1`): `learnings/*.md` ve `projects/REGISTRY.md` güncellendiğinde 2. sinyali beklemeden senkron olarak GitHub'a push eder.
- **Çok Repolu Proje Bağlama (`project-link` skill):** Açık projeleri tarayıp `templates/project/` şablonuyla `AGENTS.md` ve `.agents/learnings/PROJECT.md` kuran ve `projects/REGISTRY.md` kayıt defterine işleyen skill eklendi.
- **Hatasız Git Senkronizasyonu:** `.gitattributes`, `.gitignore` ve `$LASTEXITCODE` + otomatik `git rebase --abort` korumalı `scripts/sync.ps1` betiği eklendi.

## 1.0.0 - 2026-10-29
- İlk sürüm: görev → model eşleme tablosu (Claude Opus 5.5, Claude Sonnet 5.5, Gemini 3.8 Flash, Gemini 4 Argon, GPT-OSS 120B).
- Onay bekleme protokolü ("devam et") eklendi.
- Öğrenim günlüğü ve kendini güncelleme döngüsü eklendi.
