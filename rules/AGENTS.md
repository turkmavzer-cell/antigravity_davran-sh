# Model Yönlendirme Kuralı (antigravity_davran-sh)

> Kaynak repo: https://github.com/turkmavzer-cell/antigravity_davran-sh
> Yerel konum: `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh`
> Kural sürümü: **1.0.0**

## 1. Ne zaman devreye girer?

Kullanıcı **iş gerektiren** yeni bir görev veya araştırma verdiğinde (kod yazma, hata ayıklama,
planlama, araştırma, tarayıcı otomasyonu, dosya oluşturma, analiz vb.) **herhangi bir araç
çağırmadan veya işe başlamadan ÖNCE** bu kuralı uygula.

**Atla (doğrudan yanıtla):**
- Selamlaşma, teşekkür, tek cümlelik bilgi soruları
- Kullanıcının zaten onay verdiği bir görevin devamı ("devam et", "evet", "tamam")
- Aynı konuşmada aynı görev türü için daha önce onay alınmışsa
- Kullanıcı mesajında `!direkt` veya `!skip` geçiyorsa

## 2. Görev → Model Eşleme Tablosu

| Görev türü | Önerilen model | Gerekçe |
| :--- | :--- | :--- |
| Mimari / sistem tasarımı / veritabanı şeması | **Claude Opus 5.5** | Derin akıl yürütme, uzun vadeli tutarlılık |
| Zor bug, race condition, bellek sızıntısı, güvenlik analizi | **Claude Opus 5.5** | Çok adımlı neden-sonuç analizi |
| Kapsamlı code review / refactor planı | **Claude Opus 5.5** | Bütüncül değerlendirme |
| Kural/skill/plugin tasarlama, prompt mühendisliği | **Claude Opus 5.5** | Meta-düzey planlama |
| Özellik geliştirme, çok dosyalı kodlama | **Claude Sonnet 5.5** | Kod + araç kullanımında en dengeli |
| Tarayıcı otomasyonu (Chrome ile görev yürütme) | **Claude Sonnet 5.5** | Güvenilir çok adımlı araç kullanımı |
| Test yazma, CI/build hatalarını düzeltme | **Claude Sonnet 5.5** | Hızlı ve isabetli iterasyon |
| Küçük düzeltme, format, yorum/docstring ekleme | **Gemini 3.8 Flash** | Hız ve düşük gecikme |
| Log / test çıktısı özetleme, basit soru-cevap | **Gemini 3.8 Flash** | Hızlı tarama |
| Çeviri, metin düzenleme, kısa dokümantasyon | **Gemini 3.8 Flash** | Rutin dil işi |
| Ekran görüntüsü / UI tasarımından koda dönüştürme | **Gemini 4 Argon** | Güçlü multimodal anlama |
| Çok büyük repo / uzun doküman analizi | **Gemini 4 Argon** | Geniş bağlam penceresi |
| Web araştırması, kaynak tarama, karşılaştırmalı rapor | **Gemini 4 Argon** | Arama + uzun bağlam sentezi |
| Google Cloud / Firebase / Android / Flutter işleri | **Gemini 4 Argon** | Google ekosistemi bilgisi |
| Alternatif görüş / açık model ile kıyaslama | **GPT-OSS 120B** | Farklı bakış açısı |

Görev birden fazla türe giriyorsa **en zor alt adımı** belirleyici kabul et. Uzun görevlerde
aşama değişikliği önerebilirsin (ör. "Planlama Opus'ta, uygulama Sonnet'te").

`learnings/LEARNINGS.md` içinde bu tabloyla çelişen **onaylanmış** bir öğrenim varsa öğrenim önceliklidir.

## 3. Öneri formatı

Mevcut modeli, sistemin bildirdiği model ayarından belirle. Ardından tam olarak şu formatta
yaz ve **DUR** (hiçbir araç çağırma, işe başlama):

```
🎯 Görev türü: <tür>
🤖 Önerilen model: <model> — <tek cümlelik gerekçe>
📍 Şu anki model: <model>  →  ✅ Uygun / 🔄 Değiştirmeniz önerilir
👉 Modeli değiştirip "devam et" yazın, ya da "bu modelle devam" deyin.
```

Kullanıcı "devam et" / "bu modelle devam" / "evet" derse görevi eksiksiz yürüt.

## 4. Kendini geliştirme (öğrenme döngüsü)

Şu sinyallerden biri gelirse `learnings/LEARNINGS.md` dosyasına tarihli bir satır ekle:
- Kullanıcı öneriyi reddedip başka bir modelle devam ederse (sinyal: *override*)
- Kullanıcı "bu iş için X daha iyiydi / yanlış öneri" derse (sinyal: *düzeltme*)
- Kullanıcı öneriyi açıkça beğenirse (sinyal: *onay*)
- Menüde tabloda olmayan yeni bir model görülürse (sinyal: *yeni-model*)

**Tabloyu güncelleme eşiği:** Aynı görev türü için aynı yönde **2 veya daha fazla** sinyal
birikirse ya da kullanıcı açıkça "kuralı güncelle" derse:
1. Bu dosyadaki tabloyu güncelle ve kural sürümünü artır (yama: x.y.**z**, yeni satır: x.**y**.0).
2. `CHANGELOG.md` dosyasına ne değiştiğini ve neden değiştiğini yaz.
3. `scripts/sync.ps1 -Message "<özet>"` ile commit at ve GitHub'a gönder.
4. Kullanıcıya tek satırla bildir: "📈 Kural güncellendi: <özet>".

Ayrıntılı prosedür için `model-router-evolve` skill'ini kullan.
Öğrenimleri kaydetmek dışında, kullanıcı onayı olmadan bu repoda başka değişiklik yapma.
