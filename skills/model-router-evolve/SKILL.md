---
name: model-router-evolve
description: antigravity_davran-sh model yönlendirme kuralını geliştirir. Bir model önerisine kullanıcı itiraz ettiğinde veya onu düzelttiğinde, menüye yeni bir model geldiğinde ya da kullanıcı "kuralı güncelle", "öğrendiklerini kaydet", "repoyu senkronize et" veya "rule'u geliştir" dediğinde kullanılır.
---

# Model Router: Kendini Geliştirme Prosedürü

Repo kökü: `C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh`

## A. Öğrenim kaydetme (her sinyalde)
1. `learnings/LEARNINGS.md` tablosuna bir satır ekle:
   `| YYYY-MM-DD | <görev türü> | <önerilen> | <kullanıcının tercihi> | override/düzeltme/onay/yeni-model | <kısa not> | açık |`
2. Görev türü adlarını `rules/AGENTS.md` tablosundaki adlarla aynı tut, böylece sayım tutarlı olur.

## B. Eşik kontrolü
`açık` durumdaki satırları görev türüne göre grupla:
- Aynı görev türü için **aynı alternatif model** lehine 2+ override/düzeltme varsa → tabloyu güncelle.
- *yeni-model* sinyalinde → kullanıcıya modelin hangi görev türlerinde deneneceğini sor ve yanıta göre satır ekle.
- 3+ *onay* sinyali alan satırlar → ilgili tablo satırının gerekçesine "(doğrulandı)" ekle.

## C. Tabloyu güncelleme
1. `rules/AGENTS.md` dosyasındaki tablo satırını düzenle ve sürümü artır.
2. `plugin.json` dosyasındaki `version` değerini aynı sürüme getir.
3. İlgili öğrenimlerin durumunu `uygulandı` yap.
4. `CHANGELOG.md` dosyasına yeni sürüm başlığı altında değişikliği ve gerekçesini yaz.

## D. Senkronizasyon
```powershell
powershell -ExecutionPolicy Bypass -File "C:\Users\dell\.gemini\config\plugins\antigravity_davran-sh\scripts\sync.ps1" -Message "rule: <özet>"
```
Betik önce `pull --rebase` yapar (başka cihazdan gelen öğrenimleri alır), ardından commit atar ve gönderir.
Push başarısız olursa (kimlik doğrulama vb.) kullanıcıya bildir. Değişiklikler yerelde kalır, bir sonraki senkronizasyonda gönderilir.

## E. Kurallar
- Yalnızca bu repo içindeki dosyaları değiştir.
- Kuralın öz davranışını (önce öner, onay bekle) kullanıcı açıkça istemedikçe değiştirme.
- `rules/AGENTS.md` dosyasını 24 KB'ın altında tut. Tablo çok büyürse eski gerekçeleri kısalt.
