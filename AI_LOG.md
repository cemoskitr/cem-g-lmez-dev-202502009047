# Yapay Zekâ Kullanım ve Belgelendirme Kaydı (AI_LOG.md)

## Ödev 1 Yapay Zekâ Kullanımı
Ödev 1 kapsamında ER diyagramının Mermaid sözdizimi biçimlendirmesinde ve PostgreSQL uyumlu şema DDL SQL komutlarının yapısının oluşturulmasında teknik destek alınmıştır.

## Ödev 2 - D6 (Relational Division) Prompt Kaydı ve Analizi

### 1. AI'ya Verilen Gerçek Prompt:
> "PostgreSQL ortamında `paper_reviews` ve `papers` tablolarını kullanarak 'ICAI-2026' (conference_id = 1) konferansındaki TÜM bildirileri değerlendirmiş olan hakemlerin ID ve isimlerini getiren ilişkisel bölme (relational division) SQL sorgusunu NOT EXISTS yapısı ile yazar mısın?"

### 2. Yapay Zekâdan Gelen İlk Yanıt (SQL):
```sql
SELECT r.reviewer_id, r.full_name
FROM reviewers r
WHERE NOT EXISTS (
    SELECT p.paper_id
    FROM papers p
    WHERE p.conference_id = 1
    AND NOT EXISTS (
        SELECT 1
        FROM paper_reviews pr
        WHERE pr.paper_id = p.paper_id
        AND pr.reviewer_id = r.reviewer_id
    )
);