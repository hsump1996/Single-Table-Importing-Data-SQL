-- write your queries underneath each number:
 
-- 1. the total number of rows in the database

select COUNT(*) FROM nba_season_2020_games;

-- 2. show the first 15 rows, but only display 3 columns (your choice)

SELECT team, fg3_pct, ft_pct FROM nba_season_2020_games LIMIT 15;

-- 3. do the same as above, but chose a column to sort on, and sort in descending order

SELECT team, fg3_pct, ft_pct FROM nba_season_2020_games ORDER BY fg3_pct DESC LIMIT 15;


-- 4. add a new column without a default value

ALTER TABLE nba_season_2020_games ADD COLUMN fg_pct real;
\d nba_season_2020_games;

-- 5. set the value of that new column

UPDATE nba_season_2020_games SET fg_pct = 0.5;
select fg_pct from nba_season_2020_games limit 15;

-- 6. show only the unique (non duplicates) of a column of your choice

SELECT DISTINCT team FROM nba_season_2020_games;

-- 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group 

SELECT team, MAX(team_score) AS higest_team_score FROM nba_season_2020_games GROUP BY team ORDER BY higest_team_score asc;

-- 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 

SELECT team, MAX(team_score) AS higest_team_score FROM nba_season_2020_games GROUP BY team HAVING MAX(team_score) < 140;

-- 9. Calculated the average three point percentage of each team by grouping rows together by team and using aggregate function.

SELECT team, AVG(fg3_pct) AS average_three_point_percentage FROM nba_season_2020_games GROUP BY team;


-- 10. Calculated the average free throw percentage of each team by grouping rows together by team and using aggregate function.


SELECT team, AVG(ft_pct) AS average_free_throw_percentage FROM nba_season_2020_games GROUP BY team;


-- 11. Calculated the average free throw percentage and three point percentage of New York Knicks during home games by grouping rows together by team and using aggregate function.


SELECT team, AVG(ft_pct) AS home_average_free_throw_percentage, AVG(fg3_pct) AS home_average_three_point_percentage FROM nba_season_2020_games WHERE team = 'New York Knicks' AND local is true GROUP BY team;


-- 12. Calculated the average free throw percentage and three point percentage of New York Knicks during away games by grouping rows together by team and using aggregate function.

SELECT team, AVG(ft_pct) AS away_average_free_throw_percentage, AVG(fg3_pct) AS away_average_three_point_percentage FROM nba_season_2020_games WHERE team = 'New York Knicks' AND local is false GROUP BY team;