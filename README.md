# antigravity_davran-sh (v2.0.0)

Google Antigravity için **kendini geliştiren, kota dostu ve çok repolu çalışma sistemi** eklentisi.

## Temel Özellikler (v2.0.0)
1. **Kota/Limit Dostu Model Yönlendirme:**
   - İş gerektiren her görevden önce görevin tahmini kota yükünü, **1. önerilen modeli** ve **2. yedek (limit dostu) alternatifi** sunar.
   - Mevcut model zaten 1. önerilen model olsa bile (`✅ Uygun`), kalan kullanım limitinizi kontrol edebilmeniz için **asla onay adımını atlamaz**; `"devam et"` onayınızı bekler.
   - Ana model yüksek kotalı bir modelken rutin alt aramaları `flash` / `flash_lite` alt ajanlarına devreder.
2. **Üç Katmanlı Hafıza Sistemi:**
   - **Katman 1 (`learnings/model-routing.md`):** Model tercihleri. Kota nedeniyle yapılan geçişleri (`kota-gecisi`) kalite tercihlerinden (`override`/`düzeltme`) ayırır; 2+ override ile tabloyu günceller, 3+ onay alan eşleşmeleri `🔒 Doğrulandı` olarak işaretler.
   - **Katman 2 (`learnings/user-preferences.md`):** Tüm projelerde geçerli kişisel çalışma, dil ve git tercihleri.
   - **Katman 3 (`<proje>/.agents/learnings/PROJECT.md`):** Yalnızca ilgili projede geçerli mimari kararlar ve tuzaklar (varsayılan `sor` commit politikasıyla).
3. **Lifecycle Hooks (`hooks.json`):**
   - `SessionStart`: Yeni sohbette menüye dokunulmasa bile aktif modeli ve açık projenin bağlantı durumunu ajana bildirir.
   - `PostToolUse`: Core öğrenim dosyalarına yeni bir kayıt eklendiğinde 2. sinyali beklemeden senkron olarak GitHub'a yedekler.
4. **Proje Kayıt Defteri ve `project-link` Skill'i:**
   - Açık bir projede **"projeyi bağla"** dediğinizde teknoloji yığınını otomatik çıkarır, projeye `AGENTS.md` ve `.agents/learnings/PROJECT.md` kurar ve `projects/REGISTRY.md` dosyasına kaydeder.

## Dosya Yapısı
```text
antigravity_davran-sh/
├── plugin.json                        ← Eklenti tanımı (v2.0.0)
├── hooks.json                         ← SessionStart ve PostToolUse yaşam döngüsü kancaları
├── .gitattributes / .gitignore        ← Satır sonu (LF/CRLF) ve geçici dosya kuralları
├── rules/AGENTS.md                    ← Her zaman aktif çekirdek kural (< 6 KB)
├── skills/
│   ├── model-router-evolve/SKILL.md   ← 3 katmanlı hafıza ve tablo güncelleme prosedürü
│   └── project-link/SKILL.md          ← "projeyi bağla" kurulum prosedürü
├── learnings/
│   ├── model-routing.md               ← Katman 1: Model yönlendirme ve kota geçiş kayıtları
│   └── user-preferences.md            ← Katman 2: Kişisel kullanıcı tercihleri
├── projects/REGISTRY.md               ← Bağlı projeler ve commit politikaları
├── templates/project/                 ← Projeler için AGENTS.md ve PROJECT.md şablonları
├── scripts/
│   ├── sync.ps1                       ← Rebase-abort korumalı GitHub senkronizasyon betiği
│   ├── session-start.ps1              ← SessionStart durum enjeksiyon betiği
│   └── learning-autosync.ps1          ← PostToolUse otomatik öğrenim senkronizasyon betiği
└── CHANGELOG.md                       ← Sürüm geçmişi
```

## Kurulum (Yeni Bilgisayarda)
```powershell
cd $HOME\.gemini\config\plugins
git clone https://github.com/turkmavzer-cell/antigravity_davran-sh.git
```
Ardından Antigravity'yi yeniden başlatın.

## Kullanım Komutları
| Komut / İfade | Ajanın Davranışı |
| :--- | :--- |
| Yeni bir görev verirsiniz | Görev türünü, kota yükünü, 1. ve 2. modeli gösterir; onay bekler |
| `"devam et"` / `"bu modelle devam"` | Görevi yürütür |
| `"limitim azaldı, X ile devam et"` | `kota-gecisi` olarak kaydeder (tabloyu bozmaz) ve görevi yürütür |
| `"bu iş için X daha iyi, onunla devam et"` | `override` kaydeder, anında GitHub'a senkronize eder |
| `"projeyi bağla"` | Açık projeyi tarar, Katman 3 hafızasını kurar ve `REGISTRY.md`'ye ekler |
| `"kuralı güncelle"` | Biriken sinyalleri `rules/AGENTS.md` tablosuna işler ve push eder |
| Mesaja `!direkt` veya `!skip` eklersiniz | Onay kutusunu atlayıp doğrudan işe başlar |
