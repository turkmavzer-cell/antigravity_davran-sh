# Proje Kuralı: {{PROJE_ADI}}

> Bu proje `antigravity_davran-sh` v2.0.0 çalışma sistemine bağlıdır.
> Projeye özel öğrenimler `.agents/learnings/PROJECT.md` dosyasında tutulur.

## 1. Proje Amacı ve Özeti
- **Proje Adı:** {{PROJE_ADI}}
- **Amaç:** {{PROJE_AMACI}}
- **Teknoloji Yığını:** {{TEKNOLOJI_YIGINI}}

## 2. Geliştirme, Test ve Derleme Komutları
- **Geliştirme / Çalıştırma:** `{{DEV_KOMUTU}}`
- **Test:** `{{TEST_KOMUTU}}`
- **Build / Lint:** `{{BUILD_KOMUTU}}`

## 3. Mimari Standartlar ve Kodlama Kuralları
- Mevcut klasör yapısını ve adlandırma standartlarını koru.
- `.env` veya gizli anahtarları asla kod içine veya öğrenim dosyalarına yazma.

## 4. Projeye Özel Hafıza ve Öğrenme Kuralı (Katman 3)
1. Görev başında `.agents/learnings/PROJECT.md` dosyasını kontrol et ve oradaki mimari kararlara/tuzaklara dikkat et.
2. Bu projeye özgü yeni bir bilgi keşfettiğinde veya kullanıcı projeye özel bir düzeltme yaptığında (API adresi, kütüphane sürümü, klasör kuralı, bilinen hata/tuzak):
   - Bunu core repoya değil, **bu projedeki `.agents/learnings/PROJECT.md`** tablosuna tarihli olarak ekle.
3. **Commit Politikası (`{{COMMIT_POLITIKASI}}`):**
   - Varsayılan politika `sor` ise, `.agents/learnings/PROJECT.md` dosyasını güncelledikten sonra kod değişiklikleriyle karıştırmadan ayrı bir `docs(learnings): ...` commit'i hazırlamayı teklif et; **kullanıcı onaylamadan bu proje reposunda commit/push yapma**.
