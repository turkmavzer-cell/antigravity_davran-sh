# Bağlı Projeler Kayıt Defteri (`REGISTRY.md`)

`antigravity_davran-sh` v2.0.0 çok repolu çalışma sistemine bağlanan projelerin listesidir. Yeni bir projeyi bağlamak için ilgili proje açıkken **"projeyi bağla"** (`project-link` skill'i) demeniz yeterlidir.

## Commit Politikası Seçenekleri
- **`sor` (Varsayılan):** Projeye özel öğrenimler `.agents/learnings/PROJECT.md` dosyasına yazılır; proje reposunda commit/push yapmadan önce kullanıcıya sorulur.
- **`ayri-otomatik`:** Öğrenimler kod değişiklikleriyle karıştırılmadan ayrı bir `docs(learnings): ...` commit'i olarak otomatik commit/push edilir.
- **`kodla-birlikte`:** Öğrenimler ayrı commit yapılmaz, mevcut görev/kod commit'ine dahil edilir.

## Kayıtlı Projeler

| Proje Adı | Yerel Yol | GitHub Repo URL | Teknoloji Yığını | Bağlanma Tarihi | Commit Politikası |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `antigravity_davran-sh` (Core) | `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh` | https://github.com/turkmavzer-cell/antigravity_davran-sh | PowerShell, Markdown, Antigravity Plugin/Hooks | 2026-10-29 | `ayri-otomatik` (Hook ile anında) |
| `kedihane` | `c:\Users\dell\.gemini\antigravity\scratch\kedihane` | https://github.com/turkmavzer-cell/kedihane.git | Python, Shell, Multi-Agent Ekosistemi (8 Ajan), PSD/Medya Otomasyonu | 2026-10-31 | `otomatik-hafıza` (hafıza dışı: `sor`) |
| `AB-Aycam-SosyalMedyaYonetimi` (`Kedihane` Yönetiminde) | `E:\ab ayçam\AB-Aycam-SosyalMedyaYonetimi` (Güncelleme: `E:\ab ayçam\github-guncelleme`) | https://github.com/turkmavzer-cell/AB-Aycam-SosyalMedyaYonetimi.git | Kedihane Otomatik Çift Repo Yönetimi (Tekir + 7 Ajan), Meta Business Suite, Gemini/Flow Medya & Video Kurgu | 2026-11-07 | `kullanici-github-desktop` (`sor`) |
