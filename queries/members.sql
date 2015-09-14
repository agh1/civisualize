SELECT count(m.id) as count, t.name as membership_type_name, CAST(DATE_FORMAT(m.join_date, '%Y-01-01') AS DATE) AS joinyear, s.label as membership_status_label, IF(m.owner_membership_id,"Inherited","Primary") as inherited, IF(cc.id, 'Donor', 'Non-donor') as donor
FROM civicrm_membership m
LEFT JOIN civicrm_membership_type t
  ON t.id = m.membership_type_id
LEFT JOIN civicrm_membership_status s
  ON s.id = m.status_id
LEFT JOIN civicrm_contribution cc
  ON cc.contact_id = m.contact_id
  AND cc.is_test = 0
WHERE m.is_test = 0
GROUP BY YEAR(m.join_date), m.membership_type_id, m.status_id, inherited
