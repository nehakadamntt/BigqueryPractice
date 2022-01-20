--Exercise 1

--Given the shared file top_4000_movies_data.csv in resources folder
--1. Create a BigQuery table “Movie”
--2. Find the top 10 highest budget films, year by year, from 2016 to 2020.


WITH AMT AS
(

	with MTS AS
	(

		SELECT
		EXTRACT(YEAR FROM Release_Date) AS year,Movie_Title,Production_Budget,
		FROM `nttdata-c4e-bde.uc1_7.Movies`

	)

	SELECT * ,RANK()  OVER (PARTITION BY year ORDER BY  Production_Budget DESC,year DESC) as rank FROM MTS WHERE (year BETWEEN  2016 AND 2022)

)
SELECT * FROM AMT WHERE rank<=10 






