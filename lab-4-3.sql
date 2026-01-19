-- Who hit the most home runs in 2019, and what team did they play for?

-- Expected result:
--
-- +---------------+------------+-----------+-----------+
-- | New York Mets | Pete       | Alonso    | 53        |
-- +---------------+------------+-----------+-----------+



SELECT name, first_name, last_name, home_runs
FROM stats 
INNER JOIN players p ON player_id = p.id
INNER JOIN teams t ON team_id= t.id
WHERE year = 2019
ORDER BY home_runs DESC
LIMIT 1;