SELECT p.title AS paper_title, c.title AS conference_title
FROM papers p
JOIN conferences c ON p.conference_id = c.conference_id
WHERE p.status = 'accepted';
SELECT email FROM authors WHERE institution = 'İTÜ'
UNION
SELECT email FROM reviewers WHERE expertise_field = 'Yapay Zeka';
SELECT author_id, full_name FROM authors
EXCEPT
SELECT a.author_id, a.full_name FROM authors a JOIN papers p ON a.author_id = p.primary_author_id;
SELECT a.author_id, a.full_name FROM authors a
WHERE NOT EXISTS (
    SELECT 1 FROM papers p WHERE p.primary_author_id = a.author_id
);
SELECT a1.full_name AS author_1, a2.full_name AS author_2, a1.institution
FROM authors a1
JOIN authors a2 ON a1.institution = a2.institution AND a1.author_id < a2.author_id;
SELECT r.reviewer_id, r.full_name
FROM reviewers r
WHERE NOT EXISTS (
    SELECT p.paper_id FROM papers p WHERE p.conference_id = 1
    EXCEPT
    SELECT pr.paper_id FROM paper_reviews pr WHERE pr.reviewer_id = r.reviewer_id
);