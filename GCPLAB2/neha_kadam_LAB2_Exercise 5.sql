--Exercise 5
--Find the top 10 users (the id) who answered the most questions.
--Public Dataset: bigquery-public-data.stackoverflow
--Table involved: posts_answers, users



SELECT
u.id AS id_user,
COUNT(*) AS count
FROM `bigquery-public-data.stackoverflow.users` u
JOIN
`bigquery-public-data.stackoverflow.posts_answers` p
ON u.id=p.owner_user_id
where EXTRACT (YEAR from p.creation_date)=2010
GROUP BY u.id
ORDER BY count DESC
limit 10

