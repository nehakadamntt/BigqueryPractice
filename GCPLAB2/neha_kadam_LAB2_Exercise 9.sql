--Exercise 9
--Find for each commit on Github on a .c file of the Linux kernel, the previous and the next
--commit.
--Public Dataset: bigquery-public-data.github_repos
--Table involved: sample_commits
--Tip: Lag and Lead functions can be useful
--(see: https://cloud.google.com/bigquery/docs/reference/standard-sql/navigation_functions)



SELECT 
repo_name,
diff.new_path AS file ,
committer.date ,
LAG(commit) OVER(partition BY diff.new_path ORDER BY committer.date) AS previous_commit,
commit,
LEAD(commit) OVER(partition BY diff.new_path ORDER BY committer.date) AS next_commit
FROM `bigquery-public-data.github_repos.sample_commits`,
unnest(difference) AS diff
WHERE  diff.new_path LIKE '%kernel/acct%.c' 
