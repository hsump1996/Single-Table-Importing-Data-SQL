-- write your table creation sql here!

DROP TABLE IF EXISTS nba_season_2020_games;


-- New CREATE statement because I had to change the way my table was made

CREATE TABLE nba_season_2020_games (
    id                  SERIAL PRIMARY KEY,
    date                date NOT NULL,
    team                varchar(100) NOT NULL,
    against             varchar(100) NOT NULL,
    local               boolean NOT NULL,
    team_score          integer NOT NULL,
    rival_score         integer NOT NULL,
    fg3_pct             text,
    ft_pct              text
);




