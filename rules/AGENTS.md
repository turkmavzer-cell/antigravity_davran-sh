# Model Yönlendirme, Kota Kontrolü ve Öğrenme Kuralı (antigravity_davran-sh)

> Kaynak repo: https://github.com/turkmavzer-cell/antigravity_davran-sh
> Yerel konum: `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh`
> Kural sürümü: **2.0.0** · İletişim dili: **Türkçe**

## 1. Ne zaman devreye girer ve Kota/Limit Kontrol Protokolü

Kullanıcı **iş gerektiren** yeni bir görev verdiğinde (kod yazma, hata ayıklama, planlama, araştırma, tarayıcı otomasyonu, dosya oluşturma, analiz vb.) **herhangi bir araç çağırmadan veya işe başlamadan ÖNCE DUR** ve bu kuralı uygula.

> **ÖNEMLİ KURAL (Kota/Limit Kontrolü):** Şu anki model zaten 1. önerilen model olsa bile (`✅ Uygun`), **ASLA onay adımını atlama ve doğrudan işe başlama!** Kullanıcı işe başlamadan önce seçili modelin kalan kullanım limitine/kotasına bakar; limit azalmışsa iş yarıda kalmasın diye yedek modele geçebilir.

**Atla (doğrudan yanıtla — sadece bu durumlarda sorma):**
- Selamlaşma, teşekkür, tek cümlelik basit bilgi soruları
- Zaten onay verilmiş bir görevin kesintisiz devamı ("devam et", "evet", "tamam", "onunla devam et")
- Kullanıcı mesajında açıkça `!direkt` veya `!skip` geçiyorsa

## 2. Öneri Kutusu Formatı

Mevcut modeli sistem bildiriminden (`<USER_SETTINGS_CHANGE>` veya `SessionStart` hook mesajından) belirle. Tam olarak şu formatta yaz ve **DUR** (hiçbir araç çağırma):

```
🎯 Görev türü: <tür>
📏 Tahmini kapsam & kota yükü: <Düşük (tek adım) / Orta (2-4 adım) / Yüksek (çok dosyalı, derin analiz)>
🤖 1. Önerilen model: <model> — <tek cümlelik gerekçe>
🔄 2. Yedek (limit dostu) alternatif: <alternatif model> — <limit azsa neden bu seçilmeli>
📍 Şu anki model: <model>  →  ✅ Uygun / 🔄 Değiştirmeniz önerilir
👉 Limitinizi kontrol edin; devam için "devam et" yazın veya modeli değiştirip "devam et" deyin.
```

## 3. Görev → Model Eşleme Tablosu

| Görev türü | 1. Önerilen model | 2. Yedek (limit dostu) | Gerekçe |
| :--- | :--- | :--- | :--- |
| Mimari / sistem tasarımı / veritabanı şeması | **Claude Opus 5.5** | **Gemini 4 Argon** | Derin akıl yürütme; yedekte geniş bağlam sentezi |
| Zor bug, race condition, bellek sızıntısı, güvenlik | **Claude Opus 5.5** | **Claude Sonnet 5.5** | Çok adımlı kök neden analizi |
| Kapsamlı code review / refactor planı | **Claude Opus 5.5** | **Gemini 4 Argon** | Bütüncül değerlendirme ve mimari alternatifler |
| Kural/skill/plugin tasarlama, prompt mühendisliği | **Claude Opus 5.5** | **Gemini 4 Argon** | Meta-düzey sistem ve kurgu tasarımı |
| Özellik geliştirme, çok dosyalı kodlama | **Claude Sonnet 5.5** | **Gemini 4 Argon** | Kod üretimi ve araç kullanımında en dengeli |
| Tarayıcı otomasyonu (Chrome ile görev yürütme) | **Claude Sonnet 5.5** | **Gemini 4 Argon** | Güvenilir çok adımlı araç kullanımı |
| Test yazma, CI/build hatalarını düzeltme | **Claude Sonnet 5.5** | **Gemini 3.8 Flash** | Hızlı ve isabetli iterasyon |
| Küçük düzeltme, format, yorum/docstring ekleme | **Gemini 3.8 Flash** | **GPT-OSS 120B** | Hız, düşük gecikme ve minimum kota tüketimi |
| Log / test çıktısı özetleme, basit soru-cevap | **Gemini 3.8 Flash** | **GPT-OSS 120B** | Hızlı tarama |
| Çeviri, metin düzenleme, kısa dokümantasyon | **Gemini 3.8 Flash** | **GPT-OSS 120B** | Rutin dil işi |
| Ekran görüntüsü / UI tasarımından koda dönüştürme | **Gemini 4 Argon** | **Claude Sonnet 5.5** | Güçlü multimodal anlama |
| Çok büyük repo / uzun doküman analizi | **Gemini 4 Argon** | **Gemini 3.8 Flash** | Geniş bağlam penceresi |
| Web araştırması, kaynak tarama, karşılaştırmalı rapor | **Gemini 4 Argon** | **Gemini 3.8 Flash** | Arama + uzun bağlam sentezi |
| Google Cloud / Firebase / Android / Flutter işleri | **Gemini 4 Argon** | **Claude Sonnet 5.5** | Google ekosistemi bilgisi |
| Alternatif görüş / açık model ile kıyaslama | **GPT-OSS 120B** | **Gemini 3.8 Flash** | Farklı bakış açısı |

Görev birden fazla türe giriyorsa **en zor alt adımı** belirleyici kabul et. `learnings/model-routing.md` ve `learnings/user-preferences.md` içindeki onaylanmış tercihler önceliklidir.

## 4. Alt Ajan (Subagent) ile Kota Tasarrufu

Ana model **Claude Opus 5.5**, **Claude Sonnet 5.5** veya **Gemini 4 Argon** iken, görevin içindeki rutin alt işleri (çoklu dosya arama, log tarama, ön araştırma) ana modelin kotasını harcamamak için `invoke_subagent` aracında `Model: "flash"` veya `"flash_lite"` seçerek alt ajana devret.

## 5. Üç Katmanlı Hafıza ve Öğrenme Döngüsü

Öğrenimleri tam olarak ilgili katmana yaz (`model-router-evolve` skill prosedürünü izle):
1. **Model Tercihi (`learnings/model-routing.md`):**
   - Kullanıcı *"limit azaldı / kotadan dolayı X ile devam et"* derse → **`kota-gecisi`** olarak kaydet; tablo eşik sayımına **dahil etme**.
   - Kullanıcı *"bu iş için X daha iyi / yanlış öneri"* derse → **`override`** veya **`düzeltme`** olarak kaydet. Aynı görev türünde aynı model lehine **2+ sinyal** birikince bu dosyadaki tabloyu güncelle, sürümü artır, `CHANGELOG.md`'ye işle.
   - Kullanıcı öneriyi açıkça beğenirse veya 3+ kez onaylarsa → **`onay`** kaydet; 3+ onay alan eşleşmeleri tabloda `🔒 Doğrulandı` olarak işaretle.
2. **Kişisel Kullanıcı Profili (`learnings/user-preferences.md`):** Tüm projelerde geçerli çalışma, dil, git ve stil tercihleri.
3. **Projeye Özel Bilgi (`<proje>/.agents/learnings/PROJECT.md`):** Sadece açık olan projeye özgü mimari kararlar, tuzaklar ve komutlar. Proje reposunda commit/push yapmadan önce `projects/REGISTRY.md` içindeki commit politikasına (`sor` varsayılan) uy.
4. Kullanıcı **"projeyi bağla"** dediğinde `project-link` skill'ini çalıştır.
