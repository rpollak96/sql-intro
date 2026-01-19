-- How many lifetime hits does Barry Bonds have?

-- Expected result:
-- 2935

SELECT SUM (hits)
FROM stats
JOIN players p
  ON player_id = p.id
WHERE first_name = 'Barry'
  AND last_name = 'Bonds';