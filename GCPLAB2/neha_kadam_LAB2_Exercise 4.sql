--Exercise 4
--1. Find the first 3 most used pairs of OS and Browser from mobile devices for each
--available country on 1 st August 2017
--2. Produce a new table with the query result
--Public Dataset: bigquery-public-data.google_analytics_sample
--Table involved: ga_sessions_20170801
--Tip: ARRAY_AGG functions can be useful
--(see: https://cloud.google.com/bigquery/docs/reference/standard-sql/aggregate_functions)

CREATE OR REPLACE TABLE `uc1_7.queryResultTable` as
(
with MTE as (
   select 
   device.browser as browser,
   device.operatingSystem as operating_System,
   geoNetwork.country as country,
   ROW_NUMBER() OVER (partition by geoNetwork.country ORDER BY (count(device.browser)+count(device.operatingSystem)) ) as rank
    FROM `bigquery-public-data.google_analytics_sample.ga_sessions_20170801`
    WHERE  device.isMobile=TRUE and  geoNetwork.country<>'(not set)' and device.operatingSystem<>'(not set)' and device.browser<>'(not set)'
    group by country,operating_System,browser
   
)
 
select country,ARRAY_AGG(struct(operating_System,browser,rank)) as country_rank from MTE where rank<=3 group by country order by country 
)
