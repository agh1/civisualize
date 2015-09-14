SELECT
  DATE_SUB(CAST(DATE_FORMAT(NOW(), '%Y-%m-01') AS DATE), INTERVAL x.m MONTH) AS month,
  COUNT(DISTINCT l.membership_id) AS count,
  t.name AS membership_type_name,
  s.label as membership_status_label
FROM
  (SELECT 0 AS m UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18) x
  LEFT JOIN (SELECT membership_id, min(start_date) as start_date, max(end_date) as end_date, membership_type_id, status_id from civicrm_membership_log GROUP BY membership_id, MONTH(modified_date) ORDER BY modified_date DESC) l
    ON l.start_date <= DATE_SUB(CAST(DATE_FORMAT(NOW(), '%Y-%m-01') AS DATE), INTERVAL x.m MONTH)
    AND l.end_date >= DATE_SUB(CAST(DATE_FORMAT(NOW(), '%Y-%m-01') AS DATE), INTERVAL x.m MONTH)
  LEFT JOIN civicrm_membership_type t
    ON t.id = l.membership_type_id
  LEFT JOIN civicrm_membership_status s
    ON s.id = l.status_id
GROUP BY x.m, l.membership_type_id
ORDER BY x.m ASC, l.membership_type_id ASC, l.status_id ASC
