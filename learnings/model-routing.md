# Katman 1: Model Yönlendirme Öğrenimleri (`model-routing.md`)

Model önerilerine verilen kullanıcı tepkileri burada birikir.
- **`override` / `düzeltme`**: Aynı görev türünde aynı model lehine **2+** sinyal birikirse `rules/AGENTS.md` tablosu güncellenir.
- **`kota-gecisi`**: Kullanıcının model tercihi değil, anlık kullanım limiti/kotası nedeniyle başka bir modele geçişidir. **Tablo eşik sayımını etkilemez**, yalnızca geçmiş kaydı olarak tutulur.
- **`onay`**: Önerilen modelin başarısını doğrular. **3+** onay alan eşleşmeler tabloda `🔒 Doğrulandı` işareti alır.
- **`yeni-model`**: Menüye eklenen yeni modellerin kaydı.

**Durum değerleri:** `açık` (henüz tabloya işlenmedi) · `uygulandı` (tabloya işlendi) · `bilgi` (kota geçişi / izleme kaydı) · `reddedildi`

| Tarih | Görev türü | Önerilen | Kullanıcının tercihi | Sinyal | Not (Gerçekleşen işlem) | Durum |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| 2026-10-29 | (kurulum) | — | — | — | v1.0.0 ilk sürüm oluşturuldu | uygulandı |
| 2026-10-29 | Kapsamlı code review / refactor planı | Claude Opus 5.5 | Gemini 4 Argon | override | Proje gözden geçirme ve mimari fikir üretimi için Gemini 4 Argon tercih edildi (2. yedek model olarak tabloya eklendi, 1/2 override) | açık |
| 2026-10-29 | Uzun doküman analizi ve metin düzenleme | Claude Sonnet 4.6 | Gemini 3.8 Flash | override | Sonnet kota/limit endişesi nedeniyle mevcut model Gemini 3.8 Flash ile devam edildi | bilgi |
| 2026-10-29 | Kural/skill/plugin tasarlama, prompt mühendisliği | Claude Opus 5.5 | Claude Opus 5.5 | onay | v2.0.0 mimari planlaması ve mülakat aşaması için Opus 5.5 önerisi kabul edildi ve uygulandı | açık |
| 2026-10-29 | Kural/skill/plugin tasarlama, prompt mühendisliği | Claude Opus 5.5 | Gemini 4 Argon | kota-gecisi | Opus limiti bittiği için uygulama aşamasında yedek model Gemini 4 Argon'a geçilerek devam edildi | bilgi |
| 2026-10-31 | Zor bug, hata ayıklama & 369 sayfa veri analizi | Claude Sonnet 5.5 | Claude Sonnet 5.5 (limit yenilenmesi bekleniyor) | kota-gecisi | Claude haftalık limiti %15 kaldığı için kullanıcı 2 saat sonra limit yenilenince Sonnet 5.5 ile devam etmeyi seçti, beklemede | bilgi |
| 2026-10-31 | Tarayıcı otomasyonu (Facebook mesaj/yorum kontrolü) | Claude Sonnet 5.5 | Gemini 3.8 Flash | kota-gecisi | Sonnet 5.5 limiti bittiği için kullanıcı mevcut Gemini 3.8 Flash modeliyle devam etti | bilgi |
