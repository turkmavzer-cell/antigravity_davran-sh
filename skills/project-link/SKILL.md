---
name: project-link
description: Açık olan proje workspace'ini antigravity_davran-sh çok repolu çalışma sistemine bağlar. Kullanıcı "projeyi bağla", "bu projeyi sisteme ekle", "proje hafızasını kur" dediğinde kullanılır.
---

# Proje Bağlama Prosedürü (`project-link`)

Core repo kökü: `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh`
Şablon dizini: `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh\templates\project`
Kayıt defteri: `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh\projects\REGISTRY.md`

## Adım 1: Açık Workspace'i ve Teknoloji Yığınını Tespit Et
1. Açık olan proje dizinini belirle (aktif workspace yoksa kullanıcıya hangi klasörü bağlamak istediğini sor).
2. Proje kökündeki yapılandırma dosyalarını hızlıca tara (var olanları oku):
   - `package.json`, `tsconfig.json` (Node.js, React, Next.js, Vue, Tailwind vb.)
   - `pyproject.toml`, `requirements.txt` (Python, FastAPI, Django vb.)
   - `pubspec.yaml` (Flutter / Dart)
   - `Cargo.toml` (Rust), `go.mod` (Go), `*.csproj` / `*.sln` (.NET)
   - `README.md` (Proje amacı ve çalıştırma komutları)
   - `git remote -v` (GitHub repo URL'si — yoksa `yerel (remote yok)` olarak not et)

## Adım 2: Proje Şablonunu Kur (`AGENTS.md` ve `.agents/learnings/PROJECT.md`)
1. `templates/project/AGENTS.md` şablonunu oku ve tespit ettiğin proje bilgilerini (Proje adı, amaç, teknoloji yığını, sık kullanılan geliştirme/test/build komutları) doldurarak `<proje>/AGENTS.md` dosyasını oluştur.
   - Eğer projede zaten bir `AGENTS.md` varsa **üzerine yazma**; mevcut içeriği koruyup sonuna *"Proje Öğrenim ve Hafıza Kuralı"* bölümünü ekle.
2. `templates/project/.agents/learnings/PROJECT.md` şablonunu kullanarak `<proje>/.agents/learnings/PROJECT.md` dosyasını oluştur (varsa üzerine yazma, ilk taramadan elde edilen temel mimari notları ekle).
3. `<proje>/.agents/skills/` klasörünün mevcut olduğundan emin ol (gerekirse `.gitkeep` koy).

## Adım 3: Kayıt Defterine (`projects/REGISTRY.md`) Ekle
1. `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh\projects\REGISTRY.md` dosyasını oku.
2. Projeyi tabloya ekle (zaten varsa bilgilerini güncelle):
   - **Proje Adı:** Klasör veya paket adı
   - **Yerel Yol:** Tam yol (ör. `C:\...`)
   - **GitHub Repo:** `git remote get-url origin` çıktısı (veya `—`)
   - **Teknoloji Yığını:** Kısa özet
   - **Bağlanma Tarihi:** `YYYY-MM-DD`
   - **Commit Politikası:** Varsayılan olarak `sor` (kullanıcı farklı bir politika belirtmediyse)
3. `projects/REGISTRY.md` düzenlendiğinde `PostToolUse` hook'u otomatik olarak core repoyu GitHub ile senkronize eder (gerekirse `scripts/sync.ps1` ile doğrula).

## Adım 4: Proje Reposunda Commit Onayı (`sor` Politikası)
- Proje reposunda oluşturulan `AGENTS.md` ve `.agents/learnings/PROJECT.md` dosyalarını **otomatik commit/push yapma**.
- Kullanıcıya kurulan dosyaları özetle ve sor:
  *"Proje başarıyla bağlandı ve `projects/REGISTRY.md` güncellendi. Proje reposundaki yeni `AGENTS.md` ve `.agents/learnings/PROJECT.md` dosyalarını commit'leyip göndermemi ister misiniz?"*
