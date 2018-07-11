WITH x AS (SELECT duration FROM tpcds_reports.gen_data)
SELECT 'Seconds' as time, extract('epoch' from duration) AS value
FROM x
UNION ALL
SELECT 'Minutes', extract('epoch' from duration)/60 AS minutes
FROM x
UNION ALL
SELECT 'Hours', extract('epoch' from duration)/(60*60) AS hours 
FROM x;
