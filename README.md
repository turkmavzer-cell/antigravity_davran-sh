# antigravity_davran-sh

Google Antigravity için **akıllı ve kendini geliştiren model yönlendirme** eklentisi.

Her görevden önce o iş için en uygun modeli (Claude Opus 5.5, Claude Sonnet 5.5, Gemini 3.8 Flash,
Gemini 4 Argon, GPT-OSS 120B) önerir ve sizin onayınızı bekler. Önerilere verdiğiniz tepkileri kaydeder,
yeterli sinyal biriktiğinde kendi kural tablosunu günceller ve bu repoya gönderir.

## Yapı
```
plugin.json                        Eklenti tanımı
rules/AGENTS.md                    Her zaman aktif kural (eşleme tablosu + protokol)
skills/model-router-evolve/        Öğrenme ve güncelleme prosedürü
learnings/LEARNINGS.md             Kullanıcı geri bildirim günlüğü
CHANGELOG.md                       Kural sürüm geçmişi
scripts/sync.ps1                   GitHub senkronizasyonu
```

## Kurulum (yeni bir bilgisayarda)
```powershell
cd $HOME\.gemini\config\plugins
git clone https://github.com/turkmavzer-cell/antigravity_davran-sh.git
```
Ardından Antigravity'de yeni bir konuşma açın.

## Kullanım
| Siz | Ajan |
| :--- | :--- |
| Bir görev verirsiniz | Görev türünü ve önerilen modeli yazar, durur |
| "devam et" / "bu modelle devam" | Görevi yürütür |
| Mesaja `!direkt` eklersiniz | Öneri adımını atlar |
| "yanlış öneri, X daha iyiydi" | Öğrenim kaydeder |
| "kuralı güncelle" | Öğrenimleri tabloya işler ve GitHub'a gönderir |

## Kapatma
Ayarlar → Plugins → `antigravity_davran-sh` → devre dışı bırak.
