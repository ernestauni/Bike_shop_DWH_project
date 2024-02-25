-- 1. Filling default row for each table: 

INSERT INTO BL_3NF.ce_addresses (		-- updating address table 
	address_id,
	country,
	city,
	postal_code, 
	street,
	building_number,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES 				-- adding not applicable default row
	(-1,
	'n/a',
	'n/a',
	'n/a',
	'n/a',
	'n/a',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	'n/d',
	'n/d',
	'n/d',
	'n/d',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_genders (			-- updating genders table 
	gender_id ,
	gender_desc,
	insert_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_customers (		-- updating customers table 
	customer_id,
	cust_first_name,
	cust_last_name,
	gender_id,
	email,
	phone_number,
	address_id,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	'n/a',
	-1,
	'n/a',
	'n/a',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	'n/d',
	-1,
	'n/d',
	'n/d',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_channels (		-- updating channels table 
	channel_id,
	channel_desc,
	insert_dt,
	source_system ,
	source_entity ,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_age_groups (		-- updating age group table 
	age_group_id,
	age_group,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_product_categories (		-- updating product categories table 
	category_id,
	prod_category,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_product_subcategories (		-- updating product subcategories table 
	subcategory_id,
	prod_subcategory,
	category_id,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_products_SCD (		-- updating products table 
	product_id,
	age_group_id,
	prod_subcategory_id,
	product_desc,
	start_dt,
	end_dt,
	is_active,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	-1,
	-1,
	'n/a',
	DATE '1900-1-1',
	DATE '9999-12-31',
	TRUE,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	-1,
	-1,
	'n/d',
	DATE '1900-1-1',
	DATE '9999-12-31',
	TRUE,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_branches (		-- updating branches table 
	branch_id,
	branch_name,
	address_id,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_promo_categories (		-- updating promotions categories table 
	promo_category_id,
	promo_category,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_promotions (		-- updating promotions table 
	promotion_id,	
	promo_category_id,
	promo_name,
	promo_start_dt,
	promo_end_dt,
	discount,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	-1,
	'n/a',
	DATE '1900-1-1',
	DATE '1900-1-1',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	-1,
	'n/d',
	DATE '1900-1-1',
	DATE '1900-1-1',
	-1,
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

INSERT INTO BL_3NF.ce_sales_personnel (		-- updating sales personnel table 
	employee_id,
	empl_name,
	empl_last_name,
	email,
	phone_number,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
VALUES (		-- adding not applicable default row
	-1,
	'n/a',
	'n/a',
	'n/a',
	'n/a',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1),
	(-2,		-- adding not defined default row
	'n/d',
	'n/d',
	'n/d',
	'n/d',
	DATE '1900-1-1',
	DATE '1900-1-1',
	'MANUAL',
	'MANUAL',
	-1);
COMMIT;

	
-- 2. Filling data from source table to 3NF tables:

-- Inserting data for addresses table from both data sources:
-- Online
INSERT INTO BL_3NF.ce_addresses (
	country,
	city,
	postal_code,
	street,
	building_number,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
    COALESCE(s.country, 'n. a.') AS country,
    COALESCE(s.city, 'n. a.') AS city,
    COALESCE(s.postal_code, 'n. a.') AS postal_code,
    COALESCE(s.street, 'n. a.') AS street,
    COALESCE(s.building_number, 'n. a.') AS building_number,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.address_id AS source_id
FROM sa_online_sales.src_online_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_addresses a
	WHERE a.source_id=s.address_id
		AND a.source_system='sa_online_sales'
		AND a.source_entity='src_online_sales');
COMMIT;

-- Instore
INSERT INTO BL_3NF.ce_addresses (
	country,
	city,
	postal_code,
	street,
	building_number,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
    COALESCE(s.country, 'n. a.') AS country,
    COALESCE(s.city, 'n. a.') AS city,
    COALESCE(s.postal_code, 'n. a.') AS postal_code,
    COALESCE(s.street, 'n. a.') AS street,
    COALESCE(s.building_number, 'n. a.') AS building_number,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.address_id AS source_id
FROM sa_instore_sales.src_instore_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_addresses a
	WHERE a.source_id=s.address_id
		AND a.source_system='sa_instore_sales'
		AND a.source_entity='src_instore_sales');
COMMIT;


-- Inserting data for genders table from online sales source:
INSERT INTO BL_3NF.ce_genders (
	gender_desc,
	insert_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.gender, 'n. a.') AS gender_desc,
	DATE '1900-1-1' AS insert_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.gender_id AS source_id
FROM sa_online_sales.src_online_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_genders g
	WHERE g.source_id=s.gender_id
		AND g.source_system='sa_online_sales'
		AND g.source_entity='src_online_sales');
COMMIT;

-- Inserting data for customers table from online sales source: 
INSERT INTO BL_3NF.ce_customers (
	cust_first_name,
	cust_last_name,
	email,
	phone_number,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.first_name, 'n. a.') AS cust_first_name,
	COALESCE(s.last_name, 'n. a.') AS cust_last_name,
	COALESCE(s.email, 'n. a.') AS email,
	COALESCE(s.phone_number, 'n. a.') AS phone_number,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.customer_id AS source_id
FROM sa_online_sales.src_online_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_customers c
	WHERE c.source_id=s.customer_id
		AND c.source_system='sa_online_sales'
		AND c.source_entity='src_online_sales');
COMMIT;

-- Inserting data for channels table from both data sources:
-- Online
INSERT INTO BL_3NF.ce_channels (
	channel_desc,
	insert_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.channel_desc, 'n. a.') AS channel_desc,
	DATE '1900-1-1' AS insert_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.channel_id AS source_id
FROM sa_online_sales.src_online_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_channels c
	WHERE c.source_id=s.channel_id
		AND c.source_system='sa_online_sales'
		AND c.source_entity='src_online_sales');
COMMIT;

-- Instore
INSERT INTO BL_3NF.ce_channels (
	channel_desc,
	insert_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.channel_desc, 'n. a.') AS channel_desc,
	DATE '1900-1-1' AS insert_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.channel_id AS source_id
FROM sa_instore_sales.src_instore_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_channels c
	WHERE c.source_id=s.channel_id
		AND c.source_system='sa_instore_sales'
		AND c.source_entity='src_instore_sales');
COMMIT;

-- Inserting data for age group table from both data sources:
--1. Online
INSERT INTO BL_3NF.ce_age_groups (
	age_group,
	insert_dt,
   	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.age_group, 'n. a.') AS age_group,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.age_group_id AS source_id
FROM sa_online_sales.src_online_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_age_groups ag
	WHERE ag.source_id=s.age_group_id
		AND ag.source_system='sa_online_sales'
		AND ag.source_entity='src_online_sales');
COMMIT;

--2. Instore
INSERT INTO BL_3NF.ce_age_groups (
	age_group,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.age_group, 'n. a.') AS age_group,	
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.age_group_id AS source_id
FROM sa_instore_sales.src_instore_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_age_groups ag
	WHERE ag.source_id=s.age_group_id
		AND ag.source_system='sa_instore_sales'
		AND ag.source_entity='src_instore_sales');
COMMIT;

-- Inserting data for product categories table from both data sources:
--1. Online
INSERT INTO BL_3NF.ce_product_categories (
	prod_category,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.prod_category, 'n. a.') AS prod_category,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
 	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.prod_category_id AS source_id
FROM sa_online_sales.src_online_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_product_categories pc
	WHERE pc.source_id=s.prod_category_id
		AND pc.source_system='sa_online_sales'
		AND pc.source_entity='src_online_sales');
COMMIT;

--2. Instore
INSERT INTO BL_3NF.ce_product_categories (
	prod_category,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.prod_category, 'n. a.') AS prod_category,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.prod_category_id AS source_id
FROM sa_instore_sales.src_instore_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_product_categories pc
	WHERE pc.source_id=s.prod_category_id
		AND pc.source_system='sa_instore_sales'
		AND pc.source_entity='src_instore_sales');
COMMIT;

-- Inserting data for product subcategories table from both data sources:
--1. Online
INSERT INTO BL_3NF.ce_product_subcategories (
	prod_subcategory,
	category_id,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.prod_subcategory, 'n. a.') AS prod_subcategory,
	pc.category_id,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.prod_subcategory_id AS source_id
FROM sa_online_sales.src_online_sales s
LEFT JOIN BL_3NF.ce_product_categories pc ON s.prod_category_id = pc.source_id
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_product_subcategories ps
	WHERE ps.source_id=s.prod_subcategory_id
		AND pc.source_id=s.prod_category_id
		AND ps.source_system='sa_online_sales'
		AND ps.source_entity='src_online_sales');
COMMIT;

--2. Instore 
INSERT INTO BL_3NF.ce_product_subcategories (
	prod_subcategory,
	category_id,
	insert_dt,
 	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.prod_subcategory, 'n. a.') AS prod_subcategory,
	pc.category_id,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.prod_subcategory_id AS source_id
FROM sa_instore_sales.src_instore_sales s
LEFT JOIN BL_3NF.ce_product_categories pc ON s.prod_category_id = pc.source_id
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_product_subcategories ps
	WHERE ps.source_id=s.prod_subcategory_id
		AND pc.source_id=s.prod_category_id
		AND ps.source_system='sa_instore_sales'
		AND ps.source_entity='src_instore_sales');
COMMIT;    
   

-- Inserting data for product table from both data sources:
--1. Online 
INSERT INTO BL_3NF.ce_products_SCD (
	age_group_id,
	prod_subcategory_id,
	product_desc,
	start_dt,
	end_dt,
	is_active,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	ag.age_group_id,
	ps.subcategory_id,
	COALESCE(s.product, 'n. a.') AS product_desc,
	DATE '1900-1-1' AS start_dt,
	DATE '9999-12-31' AS end_dt,
	TRUE AS is_active,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.product_id AS source_id
FROM sa_online_sales.src_online_sales s
LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
LEFT JOIN BL_3NF.ce_product_subcategories ps ON s.prod_subcategory_id = ps.source_id
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_products_SCD p
	WHERE p.source_id=s.product_id
		AND ag.source_id=s.age_group_id
		AND ps.source_id=s.prod_subcategory_id
		AND p.source_system='sa_online_sales'
		AND p.source_entity='src_online_sales');
COMMIT;    
   
-- 2. Instore
INSERT INTO BL_3NF.ce_products_SCD (
	age_group_id,
	prod_subcategory_id,
	product_desc,
	start_dt,
	end_dt,
	is_active,
	insert_dt,
	update_dt,
	source_system,
	source_entity,
	source_id)
SELECT DISTINCT
	ag.age_group_id,
	ps.subcategory_id,
	COALESCE(s.product, 'n. a.') AS product_desc,
	DATE '1900-1-1' AS start_dt,
	DATE '9999-12-31' AS end_dt,
	TRUE AS is_active,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.product_id AS source_id
FROM sa_instore_sales.src_instore_sales s
LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
LEFT JOIN BL_3NF.ce_product_subcategories ps ON s.prod_subcategory_id = ps.source_id
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_products_SCD p
	WHERE p.source_id=s.product_id
		AND ag.source_id=s.age_group_id
		AND ps.source_id=s.prod_subcategory_id
		AND p.source_system='sa_instore_sales'
		AND p.source_entity='src_instore_sales');
COMMIT; 
  

-- Inserting data for branches table from instore sales source: 
INSERT INTO BL_3NF.ce_branches (
	branch_name,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.branch_name, 'n. a.') AS branch_name,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.branch_id AS source_id
FROM sa_instore_sales.src_instore_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_branches b
	WHERE b.source_id=s.branch_id
		AND b.source_system='sa_instore_sales'
		AND b.source_entity='src_instore_sales');
COMMIT;


-- Inserting data for promo categories table from both sources:
-- Online
INSERT INTO BL_3NF.ce_promo_categories (
	promo_category,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
SELECT DISTINCT
	s.promo_category AS promo_category,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.promo_category_id AS source_id
FROM sa_online_sales.src_online_sales s
-- not including null values:
WHERE s.promo_category IS NOT NULL 
-- check for existing data to include only new values:
AND NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_promo_categories pc
	WHERE pc.source_id=s.promo_category_id
		AND pc.source_system='sa_online_sales'
		AND pc.source_entity='src_online_sales');
COMMIT;

-- Instore
INSERT INTO BL_3NF.ce_promo_categories (
	promo_category,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
SELECT DISTINCT
	s.promo_category AS promo_category,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.promo_category_id AS source_id
FROM sa_instore_sales.src_instore_sales s
-- not including null values:
WHERE s.promo_category IS NOT NULL 
-- check for existing data to include only new values:
AND NOT EXISTS ( 
	SELECT *
	FROM BL_3NF.ce_promo_categories pc
	WHERE pc.source_id=s.promo_category_id
		AND pc.source_system='sa_instore_sales'
		AND pc.source_entity='src_instore_sales');
COMMIT;


-- Inserting data for promotions table from both sources:
-- Online
INSERT INTO BL_3NF.ce_promotions (
	promo_category_id,
	promo_name,
	promo_start_dt,
	promo_end_dt,
	discount,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
SELECT DISTINCT
	pc.promo_category_id,	
	COALESCE(s.promo_desc, 'n. a.') AS promo_name,
	COALESCE(s.promo_start_date::date, '9999-12-31') AS promo_start_dt,
	COALESCE(s.promo_end_date::date, '9999-12-31') AS promo_end_dt,
	COALESCE(s.discount::numeric, 0.00) AS discount,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_online_sales' AS source_system,
	'src_online_sales' AS source_entity,
	s.promotion_id AS source_id
FROM sa_online_sales.src_online_sales s
LEFT JOIN  BL_3NF.ce_promo_categories pc ON s.promo_category_id=pc.source_id
-- not including null values:
WHERE pc.source_id IS NOT NULL 
-- check for existing data to include only new values:
AND NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_promotions p
	WHERE p.source_id=s.promotion_id
		AND pc.source_id=s.promo_category_id
		AND p.source_system='sa_online_sales'
		AND p.source_entity='src_online_sales');
COMMIT;

-- Instore
INSERT INTO BL_3NF.ce_promotions (
	promo_category_id,
	promo_name,
	promo_start_dt,
	promo_end_dt,
	discount,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
SELECT DISTINCT
	pc.promo_category_id,	
	COALESCE(s.promo_desc, 'n. a.') AS promo_name,
	COALESCE(s.promo_start_date::date, '9999-12-31') AS promo_start_dt,
	COALESCE(s.promo_end_date::date, '9999-12-31') AS promo_end_dt,
	COALESCE(s.discount::numeric, 0.00) AS discount,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.promotion_id AS source_id
FROM sa_instore_sales.src_instore_sales s
LEFT JOIN  BL_3NF.ce_promo_categories pc ON s.promo_category_id=pc.source_id
-- not including null values:
WHERE pc.source_id IS NOT NULL 
-- check for existing data to include only new values:
AND NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_promotions p
	WHERE p.source_id=s.promotion_id
		AND pc.source_id=s.promo_category_id
		AND p.source_system='sa_instore_sales'
		AND p.source_entity='src_instore_sales');
COMMIT;


-- Inserting data for sales personnel table from instore sales source:
INSERT INTO BL_3NF.ce_sales_personnel (
	empl_name,
	empl_last_name,
	email,
	phone_number,
	insert_dt,
	update_dt,
	source_system ,
	source_entity,
	source_id)
SELECT DISTINCT
	COALESCE(s.first_name, 'n. a.') AS empl_name,
	COALESCE(s.last_name, 'n. a.') AS empl_last_name,
	COALESCE(s.email, 'n. a.') AS email,
	COALESCE(s.phone_number, 'n. a.') AS phone_number,
	DATE '1900-1-1' AS insert_dt,
	current_date AS update_dt,
	'sa_instore_sales' AS source_system,
	'src_instore_sales' AS source_entity,
	s.employee_id AS source_id
FROM sa_instore_sales.src_instore_sales s
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_sales_personnel p
	WHERE p.source_id=s.employee_id
		AND p.source_system='sa_instore_sales'
		AND p.source_entity='src_instore_sales');
COMMIT;

-- Inserting data for sales table
-- online_sales 
WITH online_data AS (
	SELECT
		date::date AS sale_date,
		cch.channel_id,
		pscd.product_id,
		cc.customer_id,
		cp.promotion_id,
		s.order_quantity::integer AS order_quantity,
		s.unit_cost::decimal(10, 2) AS unit_cost,
		s.unit_price::decimal(10, 2) AS unit_price,
		DATE '1900-1-1' AS insert_dt,
		'sa_online_sales' AS source_system,
		'src_online_sales' AS source_entity,
		s.transaction_id AS source_id
	FROM sa_online_sales.src_online_sales s
	JOIN BL_3NF.ce_channels cch ON s.channel_desc = cch.channel_desc
	JOIN BL_3NF.ce_products_SCD pscd ON s.product_id = pscd.source_id
	JOIN BL_3NF.ce_customers cc ON s.customer_id = cc.source_id
	JOIN BL_3NF.ce_promotions cp ON s.promotion_id = cp.source_id
	JOIN BL_3NF.ce_age_groups ag ON s.age_group_id=ag.source_id
	JOIN BL_3NF.ce_product_subcategories cps ON s.prod_subcategory_id=cps.source_id)
INSERT INTO BL_3NF.ce_sales (sale_date, channel_id, product_id, customer_id, branch_id, employee_id, promotion_id, order_quantity, unit_cost, unit_price, insert_dt,
	source_system,source_entity,source_id)
SELECT d.sale_date, d.channel_id, d.product_id, d.customer_id, -1, -1, d.promotion_id, d.order_quantity, d.unit_cost, d.unit_price, d.insert_dt,source_system,source_entity,source_id
FROM online_data AS d
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_sales AS sa
	WHERE sa.source_id=d.source_id
		AND d.source_system='sa_online_sales'
		AND d.source_entity='src_online_sales');
COMMIT;

-- Instore
WITH instore_data AS (
	SELECT 
		date::date AS sale_date,
		cch.channel_id,
		pscd.product_id,
		cb.branch_id,
		sp.employee_id,
		cp.promotion_id,
		s.order_quantity::integer AS order_quantity,
		s.unit_cost::decimal(10, 2) AS unit_cost,
		s.unit_price::decimal(10, 2) AS unit_price,
		DATE '1900-1-1' AS insert_dt,
		'sa_instore_sales' AS source_system,
		'src_instore_sales' AS source_entity,
		s.transaction_id AS source_id
	FROM 
		sa_instore_sales.src_instore_sales AS s
		JOIN BL_3NF.ce_channels AS cch ON s.channel_desc = cch.channel_desc
		JOIN BL_3NF.ce_products_SCD AS pscd ON s.product_id = pscd.source_id
		JOIN BL_3NF.ce_branches AS cb ON s.branch_id = cb.source_id
		JOIN BL_3NF.ce_sales_personnel AS sp ON s.employee_id = sp.source_id
		JOIN BL_3NF.ce_promotions AS cp ON s.promotion_id = cp.source_id)
INSERT INTO BL_3NF.ce_sales (sale_date, channel_id, product_id,customer_id, branch_id, employee_id , promotion_id, order_quantity, unit_cost, unit_price, insert_dt)
SELECT d.sale_date, d.channel_id, d.product_id,-1, d.branch_id, d.employee_id , d.promotion_id, d.order_quantity, d.unit_cost, d.unit_price, d.insert_dt
FROM instore_data AS d
-- check for existing data to include only new values:
WHERE NOT EXISTS (
	SELECT 1
	FROM BL_3NF.ce_sales AS sa
	WHERE sa.source_id=d.source_id
		AND d.source_system='sa_instore_sales'
		AND d.source_entity='src_instore_sales');
COMMIT;

truncate BL_3NF.ce_sales;



SELECT COUNT(transaction_id)
FROM(
SELECT
		date::date AS sale_date,
		cch.channel_id,
		pscd.product_id,
		cc.customer_id,
		cp.promotion_id,
		s.order_quantity::integer AS order_quantity,
		s.unit_cost::decimal(10, 2) AS unit_cost,
		s.unit_price::decimal(10, 2) AS unit_price,
		DATE '1900-1-1' AS insert_dt,
		'sa_online_sales' AS source_system,
		'src_online_sales' AS source_entity,
		s.transaction_id AS source_id
	FROM sa_online_sales.src_online_sales s
	JOIN BL_3NF.ce_channels cch ON s.channel_desc = cch.channel_desc
	JOIN BL_3NF.ce_products_SCD pscd ON s.product_id = pscd.source_id
	JOIN BL_3NF.ce_customers cc ON s.customer_id = cc.source_id
	JOIN BL_3NF.ce_promotions cp ON s.promotion_id = cp.source_id
	JOIN BL_3NF.ce_age_groups ag ON s.age_group_id=ag.source_id
	JOIN BL_3NF.ce_product_subcategories cps ON s.prod_subcategory_id=cps.source_id
	WHERE pscd.age_group_id = ag.age_group_id
		AND pscd.prod_subcategory_id = cps.subcategory_id
		AND pscd.product_id = s.product_id) d;