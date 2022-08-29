-- QUESTION: The meteorologists who you’re working with have asked you to get the temperature, wind speed, and precipitation for stations La Guardia and JFK, for every day in 2020, in descending order by date, and ascending order by Station ID.

SELECT
  stn, date,
  -- Use the IF function to replace 9999.9 values, which the dataset description explains is the default value when temperature is missing, with NULLs instead.

    If(
      temp = 9999.9,NULL,temp
    ) as Temperature,
    
-- Use the IF function to replace 999.9 values, which the dataset description explains is the default value when wind speed is missing, with NULLs instead.

    If(
      wdsp = "999.9", NULL, CAST(wdsp AS FLOAT64) 
    )AS Wind_Speed,

-- Use the IF function to replace 99.99 values, which the dataset description explains is the default value when precipitation is missing, with NULLs instead.

    If(
      prcp = 99.99, NULL, prcp
    )AS precipitation

FROM `bigquery-public-data.noaa_gsod.gsod2020` 
WHERE
  stn="725030" -- La Guardia

  OR stn="744860" -- JFK
ORDER BY
  date DESC,
  stn ASC
	
	
-- The meteorologists also asked a couple questions while they were preparing for the nightly news: They want the average temperature in June 2020 and the average wind_speed in December 2020. 

-- Instead of rewriting similar, but slightly different, queries over and over again, there is an easier approach: Save the results from the original query as a table for future queries. 

SELECT

AVG(Temperature) as Avg_Temp, AVG(Wind_Speed) as Avg_Windspeed

FROM

`my-first-data-358803.Demos.nyc_weather` 

WHERE

date BETWEEN '2020-06-01' AND '2020-06-30'