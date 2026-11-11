-- Ödev 2: Kısıtların (Constraints) ALTER TABLE ile Eklenmesi

-- 1. NOT NULL Kısıtları
ALTER TABLE paper_reviews 
    ALTER COLUMN score SET NOT NULL;

-- 2. UNIQUE Kısıtları
ALTER TABLE papers 
    ADD CONSTRAINT uk_papers_title UNIQUE (title);

ALTER TABLE papers 
    ADD CONSTRAINT uk_papers_conf_title UNIQUE (conference_id, title);

-- 3. CHECK Kısıtları
ALTER TABLE paper_reviews 
    ADD CONSTRAINT chk_reviews_score_range CHECK (score >= 1 AND score <= 5);

ALTER TABLE papers 
    ADD CONSTRAINT chk_papers_status_valid CHECK (status IN ('submitted', 'under_review', 'accepted', 'rejected'));

ALTER TABLE authors 
    ADD CONSTRAINT chk_authors_hindex_nonnegative CHECK (h_index >= 0);

ALTER TABLE conferences 
    ADD CONSTRAINT chk_conferences_year_valid CHECK (year >= 2000);

-- 4. Anlamlı İsimlendirilmiş Foreign Key Kısıtları ve Silme Politikaları
ALTER TABLE papers 
    DROP CONSTRAINT IF EXISTS papers_conference_id_fkey,
    ADD CONSTRAINT fk_papers_belong_to_conference 
    FOREIGN KEY (conference_id) REFERENCES conferences(conference_id) 
    ON DELETE CASCADE;

ALTER TABLE papers 
    DROP CONSTRAINT IF EXISTS papers_primary_author_id_fkey,
    ADD CONSTRAINT fk_papers_written_by_author 
    FOREIGN KEY (primary_author_id) REFERENCES authors(author_id) 
    ON DELETE RESTRICT;

ALTER TABLE paper_reviews 
    DROP CONSTRAINT IF EXISTS paper_reviews_paper_id_fkey,
    ADD CONSTRAINT fk_reviews_assigned_to_paper 
    FOREIGN KEY (paper_id) REFERENCES papers(paper_id) 
    ON DELETE CASCADE;

ALTER TABLE paper_reviews 
    DROP CONSTRAINT IF EXISTS paper_reviews_reviewer_id_fkey,
    ADD CONSTRAINT fk_reviews_written_by_reviewer 
    FOREIGN KEY (reviewer_id) REFERENCES reviewers(reviewer_id) 
    ON DELETE CASCADE;