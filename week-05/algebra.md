SELECT p.title AS paper_title, c.title AS conference_title
FROM papers p
JOIN conferences c ON p.conference_id = c.conference_id
WHERE p.status = 'accepted';