--Exercise 6
--Find the top 10 StackOverflow users (the id) by accepted responses on 2010 posts
--Public Dataset: bigquery-public-data.stackoverflow
--Table involved: stackoverflow_posts, posts_answers, users




SELECT 
DISTINCT(sp.owner_user_id) AS id_user,
COUNT(sp.owner_user_id) AS count
FROM 
`bigquery-public-data.stackoverflow.stackoverflow_posts` sp
JOIN 
`bigquery-public-data.stackoverflow.posts_answers` pa
ON
 sp.owner_user_id=pa.owner_user_id
WHERE 
sp.accepted_answer_id IS NOT NULL
GROUP BY id_user,sp.creation_date
HAVING EXTRACT (YEAR FROM sp.creation_date)=2010
ORDER BY count DESC 
LIMIT 10
