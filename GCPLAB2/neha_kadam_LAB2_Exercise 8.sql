--Exercise 8
--Find the top 10 committers in 2016 on Github repositories that uses the Java language
--Public Dataset: bigquery-public-data.github_repos
--Tables involved: languages, sample_commits




SELECT 
committer.name AS name,
COUNT(sc.repo_name) AS count
FROM `bigquery-public-data.github_repos.sample_commits` sc
JOIN `bigquery-public-data.github_repos.languages`  l
ON sc.repo_name=l.repo_name,
UNNEST(l.language) AS la
WHERE la.name="Java" AND EXTRACT(YEAR FROM sc.committer.date)=2016
GROUP BY sc.committer.name
ORDER BY count DESC
limit 10

