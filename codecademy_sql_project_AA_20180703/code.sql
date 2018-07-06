/*
From "Learn SQL from Scratch: First- and Last-Touch Attribution" assignment on Codecademy.
7/3/2018 by Art A
martialarturo@gmail.com

Lots of 'ORDER BY's added for result clarity
*/

SELECT COUNT(DISTINCT utm_campaign) AS 'Total Campaigns'
FROM page_visits;

SELECT COUNT(DISTINCT utm_source) AS 'Total Sources'
FROM page_visits;

SELECT DISTINCT utm_campaign AS 'Campaign', utm_source AS 'Source' 
FROM page_visits
ORDER BY 2;

SELECT DISTINCT page_name AS 'Page Names' FROM page_visits;

WITH first_touch AS (
SELECT user_id,
		MIN(timestamp) as first_touch_at
FROM page_visits
GROUP BY user_id)
SELECT COUNT (ft.first_touch_at) AS 'Number of FTs',
		pv.utm_campaign AS 'From Campaign'
FROM first_touch AS ft
JOIN page_visits AS pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 1 DESC;
      
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT COUNT (lt.last_touch_at) AS 'Number of LTs',
		pv.utm_campaign AS 'From Campaign'
FROM last_touch AS lt
JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 1 DESC;

SELECT COUNT(DISTINCT user_id) AS 'Users Who Have Made Purchases' FROM page_visits
WHERE page_name = '4 - purchase';

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
  	WHERE page_name = '4 - purchase'
    GROUP BY user_id)
SELECT COUNT (lt.last_touch_at) AS 'Number of Sales',
		pv.utm_campaign AS 'From Campaign'
FROM last_touch AS lt
JOIN page_visits AS pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
GROUP BY pv.utm_campaign
ORDER BY 1 DESC;
