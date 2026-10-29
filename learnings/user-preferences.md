# Katman 2: Kişisel Kullanıcı Tercihleri (`user-preferences.md`)

Bu dosyadaki tercihler **tüm projelerde ve tüm konuşmalarda** geçerlidir. Kullanıcı genel çalışma şekli, iletişim dili, git politikası veya onay akışı hakkında kalıcı bir tercih belirttiğinde buraya eklenir ve otomatik olarak GitHub'a senkronize edilir.

| Tarih | Kategori | Tercih / Kural | Kaynak / Bağlam | Durum |
| :--- | :--- | :--- | :--- | :--- |
| 2026-10-29 | Onay & Kota | Mevcut model zaten 1. önerilen model olsa bile (`✅ Uygun`), kullanıcı kalan kullanım limitini/kotasını kontrol ettiği için onay adımını **asla atlama**, her zaman öneri kutusunu gösterip "devam et" onayı bekle. | v1.0.0 düzeltme sinyali → v2.0.0 çekirdek kurala işlendi | aktif |
| 2026-10-29 | İletişim & Dil | Kullanıcıyla her zaman **Türkçe** konuş. Dokümantasyon ve kural dosyaları Türkçe olsun; kod içi tanımlayıcılar İngilizce kalabilir. | v2.0.0 kurulum tanımı | aktif |
| 2026-10-29 | Kota Tasarrufu | Ana model Opus 5.5, Sonnet 5.5 veya Gemini 4 Argon iken, rutin alt işleri (çoklu dosya arama, log tarama, ön araştırma) `invoke_subagent` ile `flash` veya `flash_lite` modeline devret. | v2.0.0 kurulum tanımı | aktif |
| 2026-10-29 | Proje Git Politikası | Bağlı proje repolarında (`.agents/learnings/PROJECT.md`) öğrenim kaydedildiğinde, varsayılan olarak kullanıcıya sormadan (`sor` politikası) proje reposunda commit/push yapma. | v2.0.0 kurulum tanımı | aktif |
