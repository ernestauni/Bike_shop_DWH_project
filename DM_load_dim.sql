-- granting all privileges in schema for DM layer to user postgres
GRANT ALL PRIVILEGES ON SCHEMA BL_DM TO postgres;

   
-- loading customers dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_customers()
AS $$
DECLARE
	rec BL_3NF.ce_customers%ROWTYPE;
	gender_desc VARCHAR;
	country VARCHAR;
	city VARCHAR;
	postal_code VARCHAR;
	street VARCHAR;
	building_number VARCHAR;
BEGIN
	-- remove all existing records:
	TRUNCATE TABLE BL_DM.dim_customers;
   -- fetch data from the ce_customers table using a FOR loop
	FOR rec IN SELECT DISTINCT * FROM BL_3NF.ce_customers LOOP
    -- fetch gender_desc from ce_genders table
	EXECUTE 'SELECT gender_desc FROM BL_3NF.ce_genders WHERE gender_id = $1' INTO gender_desc USING rec.gender_id;
    -- fetch address-related columns from ce_addresses table
	EXECUTE 'SELECT country, city, postal_code, street, building_number FROM BL_3NF.ce_addresses WHERE address_id = $1'
		INTO country, city, postal_code, street, building_number USING rec.address_id;
    -- insert data into the dim_customers table:
	INSERT INTO BL_DM.dim_customers (
		customer_id,
		cust_first_name,
		cust_last_name,
		gender_id,
		gender_desc,
		email,
		phone_number,
		address_id,
		country,
		city,
		postal_code,
		street,
		building_number,
		insert_dt,
		update_dt,
		source_system,
		source_entity) 
	VALUES (
		rec.customer_id,
		rec.cust_first_name,
		rec.cust_last_name,
		rec.gender_id,
		gender_desc,
		rec.email,
		rec.phone_number,
		rec.address_id,
		country,
		city,
		postal_code,
		street,
		building_number,
		rec.insert_dt,
		rec.update_dt,
		rec.source_system,
		rec.source_entity);
	END LOOP;
END;
$$ LANGUAGE plpgsql;


CALL BL_CL.load_dim_customers();


-- loading channels dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_channels()
AS $$
DECLARE
	rec BL_3NF.ce_channels%ROWTYPE;
BEGIN
	-- remove all existing records:
	TRUNCATE TABLE BL_DM.dim_channels;
	-- fetch data from the ce_channels table using a FOR loop
	FOR rec IN SELECT * FROM BL_3NF.ce_channels LOOP
	-- insert data into the dim_channels table
	INSERT INTO BL_DM.dim_channels (
		channel_id,
		channel_desc,
		insert_dt,
		source_system,
		source_entity) 
	VALUES (
		rec.channel_id,
		rec.channel_desc,
		rec.insert_dt,
		rec.source_system,
			rec.source_entity);
	  END LOOP;
END;
$$ LANGUAGE plpgsql;


CALL BL_DM.load_dim_channels();


-- loading branches dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_branches()
AS $$
DECLARE
	rec BL_3NF.ce_branches%ROWTYPE;
	address_rec BL_3NF.ce_addresses%ROWTYPE;
BEGIN
   -- remove all existing records, because fields are not updated often and few records:
	TRUNCATE TABLE BL_DM.dim_branches;
	-- fetch data from the ce_branches table using a FOR loop
	FOR rec IN SELECT * FROM BL_3NF.ce_branches LOOP
	-- fetch address-related columns from ce_addresses table
	EXECUTE 'SELECT * FROM BL_3NF.ce_addresses WHERE address_id = $1'
	INTO address_rec USING rec.address_id;
    -- insert data into the dim_branches table
	INSERT INTO BL_DM.dim_branches (
		branch_id,
		branch_name,
		address_id,
		country,
		city,
		postal_code,
		street,
		building_number,
		insert_dt,
		update_dt,
		source_system,
		source_entity) 
	VALUES (
		rec.branch_id,
		rec.branch_name,
		rec.address_id,
		address_rec.country,
		address_rec.city,
		address_rec.postal_code,
		address_rec.street,
		address_rec.building_number,
		rec.insert_dt,
		rec.update_dt,
		rec.source_system,
		rec.source_entity);
	END LOOP;
END;
$$ LANGUAGE plpgsql;

CALL BL_DM.load_dim_branches();


-- loading promotions dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_promotions()
AS $$
DECLARE
	rec BL_3NF.ce_promotions%ROWTYPE;
	category_desc VARCHAR;
BEGIN
	 -- Truncate the existing data in the dim_promotions table
	TRUNCATE TABLE BL_DM.dim_promotions;
	-- Fetch data from the ce_promotions table using a FOR loop
	FOR rec IN SELECT * FROM BL_3NF.ce_promotions LOOP
	-- Fetch the category description
	SELECT promo_category INTO category_desc
	FROM BL_3NF.ce_promo_categories
	WHERE promo_category_id = rec.promo_category_id;
	-- Insert data into the dim_promotions table
	INSERT INTO BL_DM.dim_promotions (
		promotion_id,
		promo_category_id,
		promo_category_desc,
		promo_name,
		promo_start_dt,
		promo_end_dt,
		discount,
		insert_dt,
		update_dt,
		source_system,
		source_entity) 
	VALUES (
		rec.promotion_id,
		rec.promo_category_id,
		category_desc,
		rec.promo_name,
		rec.promo_start_dt,
		rec.promo_end_dt,
		rec.discount,
		rec.insert_dt,
		rec.update_dt,
		rec.source_system,
		rec.source_entity);
	END LOOP;
END;
$$ LANGUAGE plpgsql;


CALL BL_DM.load_dim_promotions();


-- loading sales_personnel dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_sales_personnel()
AS $$
BEGIN
	-- Perform UPSERT operation using MERGE statement
	MERGE INTO BL_DM.dim_sales_personnel AS target
	USING (
		SELECT *
		FROM BL_3NF.ce_sales_personnel) AS s
	ON (target.employee_id = s.employee_id)
	WHEN MATCHED THEN
	UPDATE SET
		empl_first_name = s.empl_name,
		empl_last_name = s.empl_last_name,
		email = s.email,
		phone_number = s.phone_number,
		insert_dt = s.insert_dt,
		update_dt = s.update_dt,
		source_system = s.source_system,
		source_entity = s.source_entity
	WHEN NOT MATCHED THEN
	INSERT (
		employee_id,
		empl_first_name,
		empl_last_name,
		email,
		phone_number,
		insert_dt,
		update_dt,
		source_system,
		source_entity) 
	VALUES (
		s.employee_id,
		s.empl_name,
		s.empl_last_name,
		s.email,
		s.phone_number,
		s.insert_dt,
		s.update_dt,
		s.source_system,
		s.source_entity);
END;
$$ LANGUAGE plpgsql;


CALL BL_DM.load_dim_sales_personnel();


-- loading products_SCD dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_products_SCD()
AS $$
BEGIN
	-- Perform UPSERT operation using MERGE statement
	MERGE INTO BL_DM.dim_products_SCD AS target
	USING (
		SELECT p.*,
			sc.prod_subcategory,
			c.category_id,
			c.prod_category,
			ag.age_group 
		FROM BL_3NF.ce_products_scd p
		LEFT JOIN BL_3NF.ce_product_subcategories sc ON sc.subcategory_id =p.prod_subcategory_id 
		LEFT JOIN BL_3NF.ce_product_categories c ON sc.category_id = c.category_id
		LEFT JOIN BL_3NF.ce_age_groups ag ON ag.age_group_id = p.age_group_id) AS s
	ON (target.product_id = s.product_id)
	WHEN MATCHED THEN
	UPDATE SET
		age_group_id = s.age_group_id,
		age_group_desc = s.age_group,
		category_id = s.category_id,
		category_desc = s.prod_category,
		subcategory_desc = s.prod_subcategory,
		start_dt = s.start_dt,
		end_dt = s.end_dt,
		is_active = true,
		insert_dt = s.insert_dt,
		update_dt = s.update_dt,
		source_system = s.source_system,
		source_entity = s.source_entity
	WHEN NOT MATCHED THEN
	INSERT (
		product_id,
		age_group_id,
		age_group_desc,
		category_id,
		category_desc,
		subcategory_id,
		subcategory_desc,
		product_desc,
		start_dt,
		end_dt,
		is_active,
		insert_dt,
		update_dt,
		source_system,
		source_entity) 
	VALUES (
		s.product_id,
		s.age_group_id,
		s.age_group,
		s.category_id,
		s.prod_category,
		s.prod_subcategory_id,
		s.prod_subcategory,
		s.product_desc,
		s.start_dt,
		s.end_dt,
		s.is_active,
		s.insert_dt,
		s.update_dt,
		s.source_system,
		s.source_entity);
END;
$$ LANGUAGE plpgsql;


CALL BL_DM.load_dim_products_SCD();
