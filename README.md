# Akademik Konferans ve Bildiri Yönetim Sistemi

COME 381 Veritabanı Sistemleri dersi kapsamındaki Ödev 1 ve Ödev 2 projelerini içermektedir.

## Senaryo Açıklaması
Bu veritabanı senaryosu, akademik konferansların, bu konferanslara sunulan bildirilerin (makalelerin), bildirilerin birincil yazarlarının ve bildirileri değerlendiren hakemlerin süreçlerini yönetmek için tasarlanmıştır. Sistem; yazarlar (`authors`), konferanslar (`conferences`), bildiriler (`papers`), hakemler (`reviewers`) ve hakem değerlendirmelerini içeren ara tablo (`paper_reviews`) olmak üzere 5 ana tablodan oluşur. Hakemler ve bildiriler arasındaki çoka-çok (M:N) ilişki `paper_reviews` tablosu ile modellenmiştir.

## Tasarım Kararı Gerekçesi
**`paper_reviews` Ara Tablosunun Kullanımı ve Bileşik Birincil Anahtar (Composite PK):**
Bir hakemin aynı bildiriyi birden fazla kez değerlendirmesini önlemek ve veritabanı seviyesinde tekilliği garanti altına almak amacıyla `(paper_id, reviewer_id)` sütun çifti bileşik birincil anahtar (Composite Primary Key) olarak tanımlanmıştır. Bu sayede M:N ilişki sorunsuz şekilde modellenmiş ve veri tekrarı engellenmiştir.

## Kurulum ve Çalıştırma Sırası
Veritabanını sıfırdan kurmak ve testleri çalıştırmak için SQL dosyalarını şu sırada çalıştırınız:

1. `sql/schema.sql` (Temel tabloların ve birincil ilişkilerin oluşturulması)
2. `week-05/constraints.sql` (İş kurallarının ve kısıtların eklenmesi)
3. `week-05/seed.sql` (Test ve örnek verilerin yüklenmesi)
4. `week-05/violations.sql` (Kısıt ihlal testlerinin çalıştırılması)
5. `week-05/algebra.sql` (İlişkisel cebir ve D1-D6 sorgularının çalıştırılması)

## NULL ve Kısıt Davranış Notu
PostgreSQL'de `CHECK` kısıtları mantıksal olarak `FALSE` dönen durumlarda ihlal tetikler; `NULL` değer değerlendirildiğinde sonuç `UNKNOWN` olduğu için `CHECK` kısıtından geçer. Bu nedenle `score` gibi kısıt tanımlanmış alanlarda hem `CHECK` kısıtı hem de açıkça `NOT NULL` kısıtı birlikte kullanılmıştır.