INSERT INTO `demo.customers.golden`
SELECT 
  CAST(idm.id AS BYTES) AS key,

  IFNULL (sa.first_name, SPLIT_INDEX(sb.name, ' ', 0)) AS first_name,
  IFNULL (sa.last_name, SPLIT_INDEX(sb.name, ' ', 1)) AS last_name,
  sb.birthday AS date_of_birth,
  IFNULL (sa.email, sb.email_address) AS email,
  IFNULL (sa.phone, sb.contact_number) AS phone,
  sa.address AS address,

  CASE 
    WHEN sa.loyalty_tier = 'diamond' THEN sa.loyalty_tier    
    WHEN sb.membership_level = 'gold' THEN 'diamond'
    WHEN sa.loyalty_tier = 'sapphire' THEN sa.loyalty_tier    
    ELSE 'emerald'
  END AS loyalty_tier,

  IFNULL(sa.loyalty_points, 0) + (IFNULL(sb.membership_points, 0) * 5) AS loyalty_points,
  sb.favorite_drink AS favorite_drink,  
  CAST(sa.key AS STRING) AS system_a_customer_id,
  CAST(sb.key AS STRING) AS system_b_customer_id,
  IFNULL(sa.last_modified_date, sb.last_modified_date) AS last_modified_date
  
FROM `demo.customers.id-mapping` AS idm
JOIN `demo.customers.system-a` AS sa ON idm.aCustomerID = CAST(sa.key AS STRING)
JOIN `demo.customers.system-b` AS sb ON idm.bCustomerID = CAST(sb.key AS STRING)