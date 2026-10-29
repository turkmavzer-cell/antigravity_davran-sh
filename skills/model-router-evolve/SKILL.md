---
name: model-router-evolve
description: antigravity_davran-sh 3 katmanlı hafıza ve model yönlendirme kuralını geliştirir. Bir model önerisine kullanıcı itiraz ettiğinde, kota nedeniyle model değiştirdiğinde, genel bir çalışma tercihi belirttiğinde, menüye yeni bir model geldiğinde ya da "kuralı güncelle", "öğrendiklerini kaydet", "repoyu senkronize et", "rule'u geliştir" dediğinde kullanılır.
---

# Model Router & 3 Katmanlı Hafıza: Kendini Geliştirme Prosedürü

Core repo kökü: `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh`

## 1. Öğrenim Katmanını Seçme (Kapsam Ayrımı)

Kullanıcıdan gelen her geri bildirimi veya öğrenimi önce doğru katmana sınıflandır:

| Katman | Ne zaman kullanılır? | Hedef dosya | Senkronizasyon |
| :--- | :--- | :--- | :--- |
| **Katman 1: Model Yönlendirme** | Model önerisine onay, itiraz (`override`/`düzeltme`), limit/kota nedeniyle geçiş (`kota-gecisi`) veya yeni model (`yeni-model`) | `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh\learnings\model-routing.md` | `PostToolUse` hook'u (`learning-autosync.ps1`) veya `scripts/sync.ps1` ile **anında otomatik** |
| **Katman 2: Kişisel Kullanıcı Profili** | Tüm projelerde geçerli çalışma şekli, iletişim dili, commit mesajı dili, onay/kota davranışı | `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh\learnings\user-preferences.md` | `PostToolUse` hook'u veya `scripts/sync.ps1` ile **anında otomatik** |
| **Katman 3: Projeye Özel Bilgi** | Yalnızca açık olan projeye özgü mimari karar, API adresi, kütüphane sürümü, klasör yapısı, bilinen tuzak | `<aktif-workspace>\.agents\learnings\PROJECT.md` | `projects/REGISTRY.md` içindeki proje commit politikasına göre (varsayılan: **`sor`**) |

---

## 2. Katman 1: Model Yönlendirme Kaydı ve Eşik Kuralları

### A. Sinyal Türleri (`learnings/model-routing.md`)
Tabloya şu formatta satır ekle:
`| YYYY-MM-DD | <Görev türü> | <Önerilen> | <Kullanıcının tercihi> | <Sinyal> | <Not> | <Durum> |`

- **`kota-gecisi`**: Kullanıcı *"limitim azaldı / bitti / kotadan dolayı X ile devam et"* dediğinde kullanılır. Durumu `bilgi` olarak yazılır. **Ana model-başarı tablosunu bozmaz ve eşik sayımına katılmaz.**
- **`override` / `düzeltme`**: Kullanıcı *"bu iş için X modeli daha iyi / yanlış öneri / X ile devam et"* (kota belirtmeden kalite/uygunluk nedeniyle) dediğinde kullanılır. Durumu `açık` olarak yazılır.
- **`onay`**: Kullanıcı önerilen modeli açıkça beğendiğinde veya öneriyi onaylayıp görev başarıyla tamamlandığında kullanılır. Durumu `açık` olarak yazılır.
- **`yeni-model`**: Menüde tabloda olmayan yeni bir model görüldüğünde kullanılır.

### B. Tablo Güncelleme Eşikleri
1. **Model Değişikliği (2+ `override` / `düzeltme`):**
   - Aynı görev türü için **aynı alternatif model** lehine `açık` durumda **2 veya daha fazla** `override`/`düzeltme` sinyali biriktiğinde (veya kullanıcı açıkça *"kuralı güncelle"* dediğinde):
   - `rules/AGENTS.md` tablosunda o görev türünün 1. önerilen modelini (veya yedek modelini) güncelle.
   - Kural sürümünü artır (yama: `2.0.x`, yeni görev satırı veya yapısal değişiklik: `2.x.0`).
   - `plugin.json` içindeki `version` alanını aynı sürüme getir.
   - İlgili öğrenim satırlarının durumunu `uygulandı` yap.
   - `CHANGELOG.md` dosyasına yeni sürüm başlığı altında ne değiştiğini ve neden değiştiğini yaz.
   - Kullanıcıya tek satırla bildir: `📈 Kural güncellendi (vX.Y.Z): <özet>`.
2. **Doğrulanmış Eşleşme (3+ `onay`):**
   - Aynı görev türü + model eşleşmesi **3 veya daha fazla** `onay` aldığında `rules/AGENTS.md` tablosundaki modelin yanına `🔒 Doğrulandı` işareti ekle ve ilgili onay kayıtlarını `uygulandı` yap.

---

## 3. Katman 2: Kişisel Kullanıcı Tercihi Kaydı (`learnings/user-preferences.md`)

Kullanıcı tüm projelerde geçerli bir tercih söylediğinde (ör. *"Commit mesajlarım hep Türkçe olsun"*, *"Testleri çalıştırmadan önce bana sor"*):
1. `learnings/user-preferences.md` tablosuna tarihli yeni bir satır ekle (`aktif` durumunda).
2. Tercih, her konuşmada doğrudan uygulanması gereken çekirdek bir davranışsa `rules/AGENTS.md` içine de 1 cümlelik özetini ekle (boyutu < 6 KB tutarak).

---

## 4. Katman 3: Projeye Özel Öğrenim Kaydı (`.agents/learnings/PROJECT.md`)

Açık workspace'te projeye özel bir bilgi öğrenildiğinde:
1. Projede `.agents/learnings/PROJECT.md` varsa oraya tarihli satır olarak ekle.
2. Yoksa kullanıcıya projeyi sisteme bağlamak için **"projeyi bağla"** (`project-link` skill'i) komutunu verebileceğini hatırlat.
3. `projects/REGISTRY.md` dosyasından projenin **Commit Politikası** değerini kontrol et:
   - **`sor` (Varsayılan):** Dosyayı yerelde güncelle ama proje reposunda `git commit` / `git push` yapmadan önce kullanıcıya sor: *"Bu proje öğrenimini `docs(learnings): ...` olarak ayrı commit'leyip göndereyim mi?"*
   - **`ayri-otomatik`:** Kod değişikliklerine karıştırmadan yalnızca `.agents/learnings/PROJECT.md` dosyasını `docs(learnings): <özet>` mesajıyla ayrı commit'le ve push et.
   - **`kodla-birlikte`:** Ayrı commit atma; mevcut görev commit'ine dahil et.

---

## 5. GitHub Senkronizasyonu (`scripts/sync.ps1`)

`PostToolUse` hook'u (`learning-autosync.ps1`), `learnings/*.md` veya `projects/REGISTRY.md` üzerinde `write_file` / `edit_file` yapıldığında `scripts/sync.ps1` betiğini **senkron** olarak otomatik çalıştırır.
Ancak manuel senkronizasyon gerektiğinde veya `rules/AGENTS.md` + `CHANGELOG.md` güncellendiğinde şu komutu çalıştır:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh\scripts\sync.ps1" -Message "docs(learnings): <özet>"
```

## 6. Güvenlik ve Boyut Kısıtları
- Hiçbir öğrenim dosyasına API anahtarı, parola, token veya `.env` içeriği **yazma**.
- `rules/AGENTS.md` dosyasını her zaman **6 KB altında** (kesin sınır < 24 KB) öz ve net tut.
- Core repoda **asla force push (`git push --force`) yapma**.
