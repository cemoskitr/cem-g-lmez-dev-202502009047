-- Ödev 2: Test Verilerinin Yüklenmesi (Seed Data)

-- 1. Authors
INSERT INTO authors (author_id, full_name, email, institution, h_index) VALUES
(1, 'Ahmet Yılmaz', 'ahmet@univ.edu.tr', 'İTÜ', 12),
(2, 'Ayşe Kaya', 'ayse@univ.edu.tr', 'ODTÜ', 8),
(3, 'Mehmet Demir', 'mehmet@univ.edu.tr', 'BÜ', 15),
(4, 'Fatma Çelik', 'fatma@univ.edu.tr', 'Hacettepe', 5),
(5, 'Can Sever', 'can@univ.edu.tr', 'Ege Üniv', 0); -- Hiç bildirisi olmayan yazar

-- 2. Conferences
INSERT INTO conferences (conference_id, title, acronym, year, city) VALUES
(1, 'International Conference on AI', 'ICAI-2026', 2026, 'İstanbul'),
(2, 'National Software Engineering Symposium', 'UYMS-2025', 2025, 'Ankara'),
(3, 'Database Systems World', 'DSW-2026', 2026, 'İzmir');

-- 3. Reviewers
INSERT INTO reviewers (reviewer_id, full_name, email, expertise_field) VALUES
(1, 'Prof. Dr. Ali Vural', 'ali@reviewer.org', 'Yapay Zeka'),
(2, 'Doç. Dr. Zeynep Şahin', 'zeynep@reviewer.org', 'Veritabanı'),
(3, 'Dr. Emre Öztürk', 'emre@reviewer.org', 'Yazılım Mühendisliği'),
(4, 'Dr. Elif Arslan', 'elif@reviewer.org', 'Veri Bilimi'); -- Hiç değerlendirmesi olmayan hakem

-- 4. Papers
INSERT INTO papers (paper_id, title, abstract, status, conference_id, primary_author_id) VALUES
(1, 'Deep Learning in Healthcare', 'Abstract 1...', 'accepted', 1, 1),
(2, 'LLM Optimization Techniques', 'Abstract 2...', 'under_review', 1, 2),
(3, 'Relational Database Indexing', 'Abstract 3...', 'accepted', 3, 3),
(4, 'Agile Methodologies in Dev', 'Abstract 4...', 'submitted', 2, 4);

-- 5. Paper Reviews (M:N İlişkiler)
-- ICAI-2026 (Conference 1) iki bildiriye sahip: paper_id 1 ve paper_id 2.
-- Hakem 1 (Ali Vural): ICAI-2026'daki TÜM bildirileri değerlendirdi (paper 1 ve 2). [Division TESTİ İÇİN UYGUN]
-- Hakem 2 (Zeynep Şahin): ICAI-2026'daki sadece 1 bildiriyi (paper 1) değerlendirdi, paper 2 eksik kalmıştır.
INSERT INTO paper_reviews (paper_id, reviewer_id, score, comments) VALUES
(1, 1, 5, 'Mükemmel çalışma'),
(2, 1, 4, 'İyi bir makale'),
(1, 2, 3, 'Kabule yakın'),
(3, 2, 5, 'Çok başarılı'),
(3, 3, 4, 'Yeterli düzeyde');