--  Filling default row for each table in 3NF layer: 

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