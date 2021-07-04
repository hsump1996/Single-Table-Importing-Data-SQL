# Overview


1. Name / Title: NBA player stats per game for season 2019-2020
2. Link to Data: https://zenodo.org/record/3744154#.YDDQTc8zbzc
3. Source / Origin: 
	* Author or Creator: Alejandro Santamarta Martinez
	* Publication Date: April 8, 2020
	* Publisher: Zenodo
	* Version or Data Accessed: Version 1 Apr 8, 2020

4. License: Creative Commons

5. Can You Use this Data Set for Your Intended Use Case? 
Yes, this data set contains all the data I need to answer my research questions


Original File
* Format: CSV File
* Size: 4 MB
* Number of Records: 20502 Rows


Transformed/Cleaned File
* Format: CSV File
* Size: 1.3 MB
* Number of Records: 20502 Rows


The original dataset contained too many unnecessary columns. For homework3, the main focus was to examine whether there is a difference in average free throw percentage and average three point percentage for home and away games. Thus, I only used certain columns from the dataset for homework3. The essential columns include date, team, against, local, fg3_pct(three point percentage), and ft_pct(free throw percentage). For this assignment I wanted to include few other columns like team_score and rival_score. The convert.ipynb basically extracts the columns I mentioned and creates a new csv file.  


Fields or Column Headers

* Field/Column 1: date (date)
* Field/Column 2: team (string)
* Field/Column 3: against (string)
* Field/Column 4: local (boolean)
* Field/Column 5: team_score (int)
* Field/Column 6: rival_score (int)
* Field/Column 7: fg3_pct (float)
* Field/Column 8: ft_pct (float)


# Table Design

* No field was a good candidate for a primary key, so I used a serial numeric type (sequence) as a surrogate

CREATE TABLE nba_season_2020_games (
    id                  SERIAL PRIMARY KEY, (No candidates suitable for primary key, so I used serial numeric type)
    date                date NOT NULL, (The date column was in a long default date format so I used date as appropriate data type. And there were no null values)
    team                varchar(100) NOT NULL, (Teams were all strings so I selected varchar as appropriate data type. And there were no null values)
    against             varchar(100) NOT NULL, (Teams against were all strings so I selected varchar as appropriate data type. And there were no null values)
    local               boolean NOT NULL, (The local column were all either true or false so I selected boolean as appropriate date type. And there were no null values)
    team_score          integer NOT NULL, (The team scores were all numbers so I selected INTEGER as appropriate date type. And there were no null values)
    rival_score         integer NOT NULL, (The rival scores were all numbers so I selected INTEGER as appropriate date type. And there were no null values)
    fg3_pct             text, (The fg3_pct were all floating point numbers but it contained some missing values. So I temporarily selected text as data type)
    ft_pct              text (The fg3_pct were all floating point numbers but it contained some missing values. So I temporarily selected text as data type)
);


# Import

I made a slight change to the table design. Originally, columns fg3_pct and ft_pct had data tye of "real" because they contain floating point numbers. However, they also had some Null Values.  Since numeric data types have no concept of "empty string" (''), I had to figure out of way to import the data without any errors. In order to get rid of the error, I altered the data types of fg3_pct and ft_pct to text. By making this change, it would not cause any errors. After importing the csv file, I altered the data type of these columns to real using the commands below.

I added the new CREATE statement in create_table.sql because I had to change the way my table was made.




COPY nba_season_2020_games (date, team, against, local, team_score, rival_score, fg3_pct, ft_pct) FROM '/Users/sunpyohong/Desktop/Database Management/hsump1996-homework06/transformed_nba_2020_data.csv' csv HEADER;

ALTER TABLE nba_season_2020_games ALTER COLUMN ft_pct TYPE real USING ft_pct::real;
ALTER TABLE nba_season_2020_games ALTER COLUMN fg3_pct TYPE real USING fg3_pct::real;



# Database Information

postgres=# \l;


                                List of databases
    Name    |   Owner    | Encoding | Collate | Ctype |     Access privileges     
------------+------------+----------+---------+-------+---------------------------
 homework06 | sunpyohong | UTF8     | C       | C     | 
 postgres   | sunpyohong | UTF8     | C       | C     | 
 template0  | sunpyohong | UTF8     | C       | C     | =c/sunpyohong            +
            |            |          |         |       | sunpyohong=CTc/sunpyohong
 template1  | sunpyohong | UTF8     | C       | C     | =c/sunpyohong            +
            |            |          |         |       | sunpyohong=CTc/sunpyohong
            
            
            

homework06=# \dt;
                  List of relations
 Schema |         Name          | Type  |   Owner    
--------+-----------------------+-------+------------
 public | nba_season_2020_games | table | sunpyohong
(1 row)



homework06=# \d nba_season_2020_games;
                                      Table "public.nba_season_2020_games"
   Column    |          Type          | Collation | Nullable |                      Default                      
-------------+------------------------+-----------+----------+---------------------------------------------------
 id          | integer                |           | not null | nextval('nba_season_2020_games_id_seq'::regclass)
 date        | date                   |           | not null | 
 team        | character varying(100) |           | not null | 
 against     | character varying(100) |           | not null | 
 local       | boolean                |           | not null | 
 team_score  | integer                |           | not null | 
 rival_score | integer                |           | not null | 
 fg3_pct     | real                   |           |          | 
 ft_pct      | real                   |           |          | 
Indexes:
    "nba_season_2020_games_pkey" PRIMARY KEY, btree (id)



# Query Results


### 1. the total number of rows in the database

 count 
-------
 20501
(1 row)

### 2. show the first 15 rows, but only display 3 columns (your choice)

         team         | fg3_pct | ft_pct 
----------------------+---------+--------
 New Orleans Pelicans |   0.167 |      0
 New Orleans Pelicans |     0.4 |      1
 New Orleans Pelicans |   0.667 |       
 New Orleans Pelicans |   0.667 |      1
 New Orleans Pelicans |         |       
 New Orleans Pelicans |     0.6 |      1
 New Orleans Pelicans |     0.8 |       
 New Orleans Pelicans |       0 |      1
 New Orleans Pelicans |   0.333 |      1
 New Orleans Pelicans |         |  0.667
 New Orleans Pelicans |   0.333 |       
 New Orleans Pelicans |   0.143 |       
 Toronto Raptors      |   0.273 |  0.846
 Toronto Raptors      |   0.714 |  0.833
 Toronto Raptors      |     0.4 |  0.909
 
 
### 3. do the same as above, but chose a column to sort on, and sort in descending order
 
 
          team         | fg3_pct | ft_pct 
----------------------+---------+--------
 Detroit Pistons      |         |       
 Indiana Pacers       |         |       
 Detroit Pistons      |         |       
 Los Angeles Lakers   |         |      1
 Detroit Pistons      |         |  0.857
 Detroit Pistons      |         |    0.5
 Chicago Bulls        |         |       
 Los Angeles Lakers   |         |       
 New Orleans Pelicans |         |  0.667
 New Orleans Pelicans |         |       
 Los Angeles Clippers |         |  0.375
 Chicago Bulls        |         |      1
 Charlotte Hornets    |         |       
 Los Angeles Clippers |         |       
 Indiana Pacers       |         |       
(15 rows)



### 4. add a new column without a default value

homework06=# \d nba_season_2020_games;
                                      Table "public.nba_season_2020_games"
   Column    |          Type          | Collation | Nullable |                      Default                      
-------------+------------------------+-----------+----------+---------------------------------------------------
 id          | integer                |           | not null | nextval('nba_season_2020_games_id_seq'::regclass)
 date        | date                   |           | not null | 
 team        | character varying(100) |           | not null | 
 against     | character varying(100) |           | not null | 
 local       | boolean                |           | not null | 
 team_score  | integer                |           | not null | 
 rival_score | integer                |           | not null | 
 fg3_pct     | real                   |           |          | 
 ft_pct      | real                   |           |          | 
 fg_pct      | real                   |           |          | 


### 5. set the value of that new column


 fg_pct 
--------
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5
    0.5

### 6. show only the unique (non duplicates) of a column of your choice


          team          
------------------------
 Charlotte Hornets
 Philadelphia 76ers
 Washington Wizards
 Chicago Bulls
 Cleveland Cavaliers
 Sacramento Kings
 New Orleans Pelicans
 Milwaukee Bucks
 Miami Heat
 Brooklyn Nets
 Indiana Pacers
 Golden State Warriors
 Atlanta Hawks
 Toronto Raptors
 Oklahoma City Thunder
 Los Angeles Lakers
 Boston Celtics
 Houston Rockets
 Dallas Mavericks
 New York Knicks
 Memphis Grizzlies
 Utah Jazz
 Denver Nuggets
 San Antonio Spurs
 Minnesota Timberwolves
 Portland Trail Blazers
 Detroit Pistons
 Los Angeles Clippers
 Phoenix Suns
 Orlando Magic
(30 rows)



## 7.group rows together by a column value (your choice) and use an aggregate function to calculate something about that group 


          team          | higest_team_score 
------------------------+-------------------
 Indiana Pacers         |               129
 Utah Jazz              |               132
 Sacramento Kings       |               133
 Denver Nuggets         |               134
 Cleveland Cavaliers    |               134
 Golden State Warriors  |               134
 Chicago Bulls          |               136
 Orlando Magic          |               136
 Detroit Pistons        |               136
 Miami Heat             |               137
 Charlotte Hornets      |               138
 Portland Trail Blazers |               139
 New Orleans Pelicans   |               139
 Brooklyn Nets          |               139
 Memphis Grizzlies      |               140
 Toronto Raptors        |               140
 Oklahoma City Thunder  |               140
 Phoenix Suns           |               140
 Boston Celtics         |               141
 Philadelphia 76ers     |               141
 Los Angeles Lakers     |               142
 Minnesota Timberwolves |               142
 Dallas Mavericks       |               143
 New York Knicks        |               143
 San Antonio Spurs      |               145
 Los Angeles Clippers   |               150
 Milwaukee Bucks        |               151
 Atlanta Hawks          |               152
 Washington Wizards     |               158
 Houston Rockets        |               159
 
 
 ## 8. now, using the same grouping query or creating another one, find a way to filter the query results based on the values for the groups 
 
           team          | higest_team_score 
------------------------+-------------------
 Charlotte Hornets      |               138
 Chicago Bulls          |               136
 Cleveland Cavaliers    |               134
 Sacramento Kings       |               133
 New Orleans Pelicans   |               139
 Miami Heat             |               137
 Brooklyn Nets          |               139
 Indiana Pacers         |               129
 Golden State Warriors  |               134
 Utah Jazz              |               132
 Denver Nuggets         |               134
 Portland Trail Blazers |               139
 Detroit Pistons        |               136
 Orlando Magic          |               136
 
 
 
 ## 9. Calculated the average three point percentage of each team by grouping rows together by team and using aggregate function.

 
           team          | average_three_point_percentage 
------------------------+--------------------------------
 Charlotte Hornets      |             0.3142614512924702
 Philadelphia 76ers     |            0.34133511675445366
 Washington Wizards     |             0.3395224723839358
 Chicago Bulls          |             0.3234172675946205
 Cleveland Cavaliers    |             0.2987633600887906
 Sacramento Kings       |             0.3205520010888577
 New Orleans Pelicans   |            0.34774044389935804
 Milwaukee Bucks        |            0.32546177030592666
 Miami Heat             |             0.3505637870771895
 Brooklyn Nets          |            0.31828056240010116
 Indiana Pacers         |             0.3252953677995555
 Golden State Warriors  |            0.29880879632772495
 Atlanta Hawks          |             0.2910831929239838
 Toronto Raptors        |            0.33057481855371573
 Oklahoma City Thunder  |            0.32265111686129117
 Los Angeles Lakers     |            0.32881921038677014
 Boston Celtics         |            0.32741568690421535
 Houston Rockets        |            0.31719600135087966
 Dallas Mavericks       |            0.34477740984125393
 New York Knicks        |            0.30007360953188883
 Memphis Grizzlies      |            0.32871428661766244
 Utah Jazz              |             0.3545922760415998
 Denver Nuggets         |             0.3284520806229352
 San Antonio Spurs      |            0.33635742237675004
 Minnesota Timberwolves |            0.30578896226724245
 Portland Trail Blazers |            0.33692531224293826
 Detroit Pistons        |            0.33806194783048293
 Los Angeles Clippers   |             0.3434007568936267
 Phoenix Suns           |             0.3207005456549719
 Orlando Magic          |            0.30963186895126826
(30 rows)

 
 
 ## 10. Calculated the average free throw percentage of each team by grouping rows together by team and using aggregate function.

          team          | average_free_throw_percentage 
------------------------+-------------------------------
 Charlotte Hornets      |            0.7262146344998988
 Philadelphia 76ers     |            0.7326250006021424
 Washington Wizards     |            0.7613673968616773
 Chicago Bulls          |            0.7362187503216168
 Cleveland Cavaliers    |            0.7575412376486149
 Sacramento Kings       |            0.7762925532904077
 New Orleans Pelicans   |            0.6972945740672661
 Milwaukee Bucks        |            0.7682000001010142
 Miami Heat             |            0.7729222220265203
 Brooklyn Nets          |             0.722447499781847
 Indiana Pacers         |            0.7633085716196469
 Golden State Warriors  |            0.7926643191368927
 Atlanta Hawks          |            0.7729822336719726
 Toronto Raptors        |             0.777884210881434
 Oklahoma City Thunder  |            0.7784172841060308
 Los Angeles Lakers     |             0.689804407970636
 Boston Celtics         |            0.7892888891844102
 Houston Rockets        |            0.7312334377306869
 Dallas Mavericks       |            0.7878206389468777
 New York Knicks        |            0.6937070221213971
 Memphis Grizzlies      |            0.7549200974062049
 Utah Jazz              |            0.7694125683581243
 Denver Nuggets         |            0.7732046036159291
 San Antonio Spurs      |            0.7896275512722074
 Minnesota Timberwolves |            0.7425555555052769
 Portland Trail Blazers |            0.7778473284105005
 Detroit Pistons        |            0.7492537313506971
 Los Angeles Clippers   |            0.7807178080898441
 Phoenix Suns           |            0.7860963541703919
 Orlando Magic          |            0.7677470453382947
(30 rows)

 
 
 ## 11. Calculated the average free throw percentage and three point percentage of New York Knicks during 'home' games by grouping rows together by team and using aggregate function.
 
      team       | home_average_free_throw_percentage | home_average_three_point_percentage 
-----------------+------------------------------------+-------------------------------------
 New York Knicks |                 0.7029248828619299 |                  0.2814645398381754
(1 row)

 
 
 
 ## 12. Calculated the average free throw percentage and three point percentage of New York Knicks during 'away' games by grouping rows together by team and using aggregate function.
 
       team       | away_average_free_throw_percentage | away_average_three_point_percentage 
-----------------+------------------------------------+-------------------------------------
 New York Knicks |                 0.6838900004327297 |                 0.31915636463598773
(1 row)
