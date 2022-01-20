--Exercise 6
--Find the top 10 StackOverflow users (the id) by accepted responses on 2010 posts
--Public Dataset: bigquery-public-data.stackoverflow
--Table involved: stackoverflow_posts, posts_answers, users

WITH MTS AS(
SELECT 
p.owner_user_id AS id_user,
FROM
`bigquery-public-data.stackoverflow.stackoverflow_posts` pa
JOIN 
`bigquery-public-data.stackoverflow.posts_answers` p
ON pa.accepted_answer_id=p.id
WHERE 
pa.accepted_answer_id IS NOT NULL AND
EXTRACT (YEAR FROM p.creation_date)=2010
)
SELECT u.id AS user_id ,COUNT(*) AS count FROM MTS a
JOIN `bigquery-public-data.stackoverflow.users` u
ON u.id= a.id_user
GROUP BY u.id
ORDER BY count DESC
LIMIT 10
