# Foreign Key Silme Politikaları (ON DELETE) Analizi

## 1. Silme Politikalarının Tanımı ve Farkları

- **CASCADE:** Ana tablodan (parent) bir kayıt silindiğinde, o kayda bağlı olan tüm alt tablo (child) kayıtları da otomatik olarak silinir.
- **RESTRICT:** Ana tablodan bir kayıt silinmeye çalışıldığında, eğer alt tabloda ona bağlı en az bir kayıt varsa silme işlemine derhal izin vermez ve hata döndürür.
- **NO ACTION:** `RESTRICT` ile benzerdir; ancak denetimi işlem (transaction) sonuna kadar erteleyebilir. PostgreSQL varsayılanında silme anında kısıtı kontrol eder.

## 2. Tasarımdaki Silme Politikaları Seçimleri ve Gerekçeleri

1. **`fk_papers_belong_to_conference` (ON DELETE CASCADE):**
   - **Gerekçe:** Bir konferans veritabanından tamamen silindiğinde veya iptal edildiğinde, o konferansa sunulan bildirilerin veritabanında kalmasının bir anlamı yoktur.

2. **`fk_papers_written_by_author` (ON DELETE RESTRICT):**
   - **Gerekçe:** Sistemde birincil yazarı olan aktif bir bildiri varken, o yazarın veritabanından kazaen silinmesini engellemek gerekir. Yanlışlıkla veri kaybını önlemek için `RESTRICT` seçilmiştir.

3. **`fk_reviews_assigned_to_paper` (ON DELETE CASCADE):**
   - **Gerekçe:** Bir bildiri sistemden silindiğinde, o bildiriye ait değerlendirmelerin de otomatik olarak temizlenmesi gerekir.

## 3. CASCADE Davranışının Canlı Testi (Transaction ve ROLLBACK ile)

```sql
BEGIN;
-- Silme öncesi kayıt sayıları
SELECT count(*) FROM papers;        -- Örn: 4 bildiri
SELECT count(*) FROM paper_reviews;  -- Örn: 5 değerlendirme

-- Bildiri 1'i siliyoruz (ON DELETE CASCADE)
DELETE FROM papers WHERE paper_id = 1;

-- Silme sonrası kayıt sayıları
SELECT count(*) FROM papers;        -- 3 bildiriye düştü
SELECT count(*) FROM paper_reviews;  -- 3 değerlendirmeye düştü (İlişkili 2 değerlendirme otomatik silindi)

ROLLBACK; -- Veri kaybını önlemek için işlemi geri alıyoruz