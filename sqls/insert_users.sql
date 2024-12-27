INSERT INTO users (login, passwd)
SELECT CONCAT('111', level), CONCAT('111', level)
FROM (SELECT DISTINCT level FROM players) AS distinct_levels;

