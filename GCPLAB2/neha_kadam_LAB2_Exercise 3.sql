--Exercise 3
--Find how many times a page it was visited in July 2017. Group by date the result
--Public Dataset: bigquery-public-data.google_analytics_sample
--Table involved: ga_sessions_201707* (wildcard)

SELECT 
CAST(date AS DATE FORMAT 'YYYYMMDD') as date,
hits.page.pagePath AS pagePath,
COUNT(hits.page.pagePath) as counter
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_201707*`,
UNNEST(hits) as hits
GROUP BY date,pagePath
order by date,counter DESC
