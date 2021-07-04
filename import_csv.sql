-- write your COPY statement to import a csv here


COPY nba_season_2020_games (date, team, against, local, team_score, rival_score, fg3_pct, ft_pct) FROM '/Users/sunpyohong/Desktop/Database Management/hsump1996-homework06/transformed_nba_2020_data.csv' csv HEADER;

ALTER TABLE nba_season_2020_games ALTER COLUMN ft_pct TYPE real USING ft_pct::real;
ALTER TABLE nba_season_2020_games ALTER COLUMN fg3_pct TYPE real USING fg3_pct::real;
