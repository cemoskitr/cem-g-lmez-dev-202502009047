-- Ödev 2: Kısıt İhlal Testleri (Constraint Violation Tests)

-- T01: UNIQUE Kısıtı İhlali (Aynı email ile yazar ekleme denemesi)
-- Beklenen Durum: SQLSTATE 23505 (unique_violation)
INSERT INTO authors (full_name, email, institution, h_index) 
VALUES ('Test Yazar', 'ahmet@univ.edu.tr', 'Test Üniv', 3);

-- T02: CHECK Kısıtı İhlali (Negatif h_index denemesi)
-- Beklenen Durum: SQLSTATE 23514 (check_violation)
INSERT INTO authors (full_name, email, institution, h_index) 
VALUES ('Hatalı Yazar', 'hatali@univ.edu.tr', 'Test Üniv', -5);

-- T03: CHECK Kısıtı İhlali (Geçersiz score denemesi > 5)
-- Beklenen Durum: SQLSTATE 23514 (check_violation)
INSERT INTO paper_reviews (paper_id, reviewer_id, score, comments) 
VALUES (1, 3, 10, 'Hatalı puan');

-- T04: CHECK Kısıtı İhlali (Geçersiz status değeri)
-- Beklenen Durum: SQLSTATE 23514 (check_violation)
INSERT INTO papers (title, status, conference_id, primary_author_id) 
VALUES ('Hatalı Bildiri', 'published', 1, 1);

-- T05: FOREIGN KEY Kısıtı İhlali (Var olmayan conference_id ile bildiri ekleme)
-- Beklenen Durum: SQLSTATE 23503 (foreign_key_violation)
INSERT INTO papers (title, status, conference_id, primary_author_id) 
VALUES ('Olmayan Konferans Bildirisi', 'submitted', 999, 1);

-- T06: FOREIGN KEY / RESTRICT İhlali (Bildirisi olan bir yazarı silme denemesi)
-- Beklenen Durum: SQLSTATE 23503 (foreign_key_violation)
DELETE FROM authors WHERE author_id = 1;

-- T07: NOT NULL Kısıtı İhlali (score değerine NULL verme denemesi)
-- Beklenen Durum: SQLSTATE 23502 (not_null_violation)
INSERT INTO paper_reviews (paper_id, reviewer_id, score, comments) 
VALUES (2, 3, NULL, 'Eksik puan');

-- T08: Composite UNIQUE / Primary Key İhlali (Aynı hakemin aynı bildiriyi 2. kez değerlendirmesi)
-- Beklenen Durum: SQLSTATE 23505 (unique_violation)
INSERT INTO paper_reviews (paper_id, reviewer_id, score, comments) 
VALUES (1, 1, 4, 'Tekrar değerlendirme');

-- T09: BAŞARILI Sınır Testi 1 (score = 1 ve score = 5 sınır değerleri)
-- Beklenen Durum: OK (Başarılı)
INSERT INTO paper_reviews (paper_id, reviewer_id, score, comments) 
VALUES (4, 4, 1, 'En düşük geçerli puan');

-- T10: BAŞARILI Sınır Testi 2 (h_index = 0 sınır değeri)
-- Beklenen Durum: OK (Başarılı)
INSERT INTO authors (full_name, email, institution, h_index) 
VALUES ('Yeni Araştırmacı', 'yeni@univ.edu.tr', 'Gazi Üniv', 0);