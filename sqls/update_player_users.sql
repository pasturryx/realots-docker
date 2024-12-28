UPDATE players p
JOIN users u ON u.login = CONCAT('111', p.level)
SET p.account_nr = CONCAT('111', p.level)

