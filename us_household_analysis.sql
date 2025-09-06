	
				 # PART 2: US Household Income exploratory Data Analysis

# Top 10 Largest State by Land
SELECT state_name, sum(Aland), sum(Awater) 
FROM us_project.USHouseholdIncome
Group by state_name
Order by 2 Desc
Limit 10;

# Top 10 Largest State by water
SELECT state_name, sum(Aland), sum(Awater) 
FROM us_project.USHouseholdIncome
Group by state_name
Order by 3 Desc
Limit 10;


# The Average and Median Income by State
Select u.state_name, Round(avg(mean),1) AS avg_mean_income, Round(avg(median),1)AS avg_mean_income
From USHouseholdIncome u
Inner join ushouseholdincome_statistics us
      on u.id = us.id
Where mean <> 0
Group by u.state_name
Order by 2
Limit 5;

# Top 5 Lowest Household Income States
Select u.state_name, Round(avg(mean),1) AS avg_mean_income, Round(avg(median),1) AS avg_mean_income
From USHouseholdIncome u
Inner join ushouseholdincome_statistics us
      on u.id = us.id
Where mean <> 0
Group by u.state_name
Order by 2 
Limit 5;


# Top 10 Highest State Household Income 
Select u.state_name, Round(avg(mean),1) AS avg_mean_income, Round(avg(median),1) AS avg_mean_income
From USHouseholdIncome u
Inner join ushouseholdincome_statistics us
      on u.id = us.id
Where mean <> 0
Group by u.state_name
Order by 2 Desc
Limit 10;

# Highest Houselehold Avgerage Income City
Select u.state_name, city, Round(avg(mean),1) AS avg_mean_income
From USHouseholdIncome u
Inner join ushouseholdincome_statistics us
      on u.id = us.id
Group by u.state_name, city
Order by 3 Desc;

# Share of Each State’s Area Covered by Water
SELECT
  TRIM(UPPER(u.State_Name)) AS state,
  SUM(u.AWater) AS total_water,
  SUM(u.ALand)  AS total_land,
  ROUND(100 * SUM(u.AWater) / NULLIF(SUM(u.ALand)+SUM(u.AWater),0), 2) AS water_percentage
FROM USHouseholdIncome u
JOIN ushouseholdincome_statistics us ON u.id = us.id
WHERE us.mean   IS NOT NULL
  AND us.median IS NOT NULL
GROUP BY TRIM(UPPER(u.State_Name))
ORDER BY water_percentage DESC;

# Top 10 States with the Lowest Household Income
SELECT 
  u.state_name,
  ROUND(AVG(us.median), 1) AS avg_median_income,
  ROUND(AVG(us.mean),   1) AS avg_mean_income
FROM USHouseholdIncome u
JOIN ushouseholdincome_statistics us 
  ON u.id = us.id
WHERE us.median IS NOT NULL AND us.mean IS NOT NULL
GROUP BY u.state_name
ORDER BY avg_median_income ASC
LIMIT 10;


# States with the Most Water-Dominated Areas (AWater > ALand)
SELECT
  TRIM(UPPER(u.state_name)) AS state,
  SUM(CASE WHEN u.AWater > u.ALand THEN 1 ELSE 0 END) AS places_more_water,
  COUNT(*) AS total_places,
  ROUND(100.0 * SUM(CASE WHEN u.AWater > u.ALand THEN 1 ELSE 0 END) / COUNT(*), 2) AS pct_more_water
FROM USHouseholdIncome u
GROUP BY TRIM(UPPER(u.state_name))
HAVING places_more_water > 0
ORDER BY places_more_water DESC, pct_more_water DESC;

