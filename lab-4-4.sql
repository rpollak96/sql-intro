-- Who was the leading home run hitter for each team in 2019?
-- NOTE: need more advanced SQL to answer this question without
--       raising a warning: "Field of aggregated query neither grouped nor aggregated"

-- Expected result:
--
-- +-------------------------------+------------+-------------+----------------------+
-- | Arizona Diamondbacks          | Eduardo    | Escobar     | 35                   |
-- | Atlanta Braves                | Ronald     | Acuna       | 41                   |
-- | Baltimore Orioles             | Trey       | Mancini     | 35                   |
-- | Boston Red Sox                | J. D.      | Martinez    | 36                   |
-- | Chicago Cubs                  | Kyle       | Schwarber   | 38                   |
-- | Chicago White Sox             | Jose       | Abreu       | 33                   |
-- | Cincinnati Reds               | Eugenio    | Suarez      | 49                   |
-- | Cleveland Indians             | Carlos     | Santana     | 34                   |
-- | Colorado Rockies              | Nolan      | Arenado     | 41                   |
-- | Detroit Tigers                | Brandon    | Dixon       | 15                   |
-- | Houston Astros                | Alex       | Bregman     | 41                   |
-- | Kansas City Royals            | Jorge      | Soler       | 48                   |
-- | Los Angeles Angels of Anaheim | Mike       | Trout       | 45                   |
-- | Los Angeles Dodgers           | Cody       | Bellinger   | 47                   |
-- | Miami Marlins                 | Starlin    | Castro      | 22                   |
-- | Milwaukee Brewers             | Christian  | Yelich      | 44                   |
-- | Minnesota Twins               | Nelson     | Cruz        | 41                   |
-- | New York Mets                 | Pete       | Alonso      | 53                   |
-- | New York Yankees              | Gleyber    | Torres      | 38                   |
-- | Oakland Athletics             | Matt       | Chapman     | 36                   |
-- | Philadelphia Phillies         | Bryce      | Harper      | 35                   |
-- | Pittsburgh Pirates            | Josh       | Bell        | 37                   |
-- | San Diego Padres              | Hunter     | Renfroe     | 33                   |
-- | San Francisco Giants          | Kevin      | Pillar      | 21                   |
-- | Seattle Mariners              | Dan        | Vogelbach   | 30                   |
-- | St. Louis Cardinals           | Paul       | Goldschmidt | 34                   |
-- | Tampa Bay Rays                | Austin     | Meadows     | 33                   |
-- | Texas Rangers                 | Rougned    | Odor        | 30                   |
-- | Toronto Blue Jays             | Randal     | Grichuk     | 31                   |
-- | Washington Nationals          | Anthony    | Rendon      | 34                   |
-- +-------------------------------+------------+-------------+----------------------+


WITH team_hr_totals AS (
    SELECT
        t.id AS team_id,
        t.name AS team_name,
        p.id AS player_id,
        p.first_name,
        p.last_name,
        SUM(s.home_runs) AS total_home_runs
    FROM stats s
    JOIN teams t
      ON s.team_id = t.id
    JOIN players p
      ON s.player_id = p.id
    WHERE t.year = 2019
    GROUP BY
        t.id, t.name, p.id, p.first_name, p.last_name
),
ranked_hitters AS (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY team_id
               ORDER BY total_home_runs DESC
           ) AS hr_rank
    FROM team_hr_totals
)
SELECT
    team_name,
    first_name,
    last_name,
    total_home_runs
FROM ranked_hitters
WHERE hr_rank = 1
ORDER BY team_name;
