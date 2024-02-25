-- granting all privileges in schema for DM layer to user postgres
GRANT ALL PRIVILEGES ON SCHEMA BL_3NF TO postgres;


-- function to load online address
CREATE OR REPLACE PROCEDURE BL_CL.load_online_addresses()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online addresses 
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
    	COALESCE (s.postal_code, 'n. a.') AS postal_code,
		COALESCE(s.street, 'n. a.') AS street,
		COALESCE(s.building_number, 'n. a.') AS building_number,
		DATE '1900-01-01' AS insert_dt,
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
			AND a.country=s.country
			AND a.city=s.city 
			AND a.postal_code=s.postal_code
			AND a.street=s.street 
			AND a.building_number=s.building_number
			AND a.source_system='sa_online_sales'
			AND a.source_entity='src_online_sales');
	-- update for log table:
	v_procedure_name='load_online_addresses';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- function to load instore address
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_addresses()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new instore addresses 
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
		DATE '1900-01-01' AS insert_dt,
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
			AND a.country=s.country
			AND a.city=s.city 
			AND a.postal_code=s.postal_code
			AND a.street=s.street 
			AND a.building_number=s.building_number
			AND a.source_system='sa_instore_sales'
			AND a.source_entity='src_instore_sales');
	-- update for log table:	
	v_procedure_name='load_instore_addresses';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- function to load genders table
CREATE OR REPLACE PROCEDURE BL_CL.load_genders()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new genders
    INSERT INTO BL_3NF.ce_genders (
		gender_desc,
		insert_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.gender, 'n. a.') AS gender_desc,
		DATE '1900-01-01' AS insert_dt,
		'sa_online_sales' AS source_system,
		'src_online_sales' AS source_entity,
		s.gender_id AS source_id
	FROM sa_online_sales.src_online_sales s
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_genders g
		WHERE g.source_id=s.gender_id
			AND g.gender_desc=s.gender
			AND g.source_system='sa_online_sales'
			AND g.source_entity='src_online_sales');
	-- update for log table:
	v_procedure_name='load_genders';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load customers table
CREATE OR REPLACE PROCEDURE BL_CL.load_customers()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new customers
    INSERT INTO BL_3NF.ce_customers (
		cust_first_name,
		cust_last_name,
		gender_id,
		email,
		phone_number,
		address_id,
		insert_dt,
		update_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.first_name, 'n. a.') AS cust_first_name,
		COALESCE(s.last_name, 'n. a.') AS cust_last_name,
		gn.gender_id,
		COALESCE(s.email, 'n. a.') AS email,
		COALESCE(s.phone_number, 'n. a.') AS phone_number,
		ad.address_id,
		DATE '1900-01-01' AS insert_dt,
		current_date AS update_dt,
		'sa_online_sales' AS source_system,
		'src_online_sales' AS source_entity,
		s.customer_id AS source_id
	FROM sa_online_sales.src_online_sales s
	LEFT JOIN BL_3NF.ce_genders gn ON gn.source_id=s.gender_id 
	LEFT JOIN BL_3NF.ce_addresses ad ON ad.source_id=s.address_id 
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_customers c
		WHERE c.source_id=s.customer_id
			AND c.cust_first_name=s.first_name
			AND c.cust_last_name=s.last_name
			AND c.email=s.email
			AND c.phone_number=s.phone_number 
			AND c.address_id=ad.address_id
			AND c.source_system='sa_online_sales'
			AND c.source_entity='src_online_sales');
		-- update for log table:
	v_procedure_name='load_customers';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load channels table
CREATE OR REPLACE PROCEDURE BL_CL.load_online_channels()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online source channels 
	INSERT INTO BL_3NF.ce_channels (
		channel_desc,
		insert_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.channel_desc, 'n. a.') AS channel_desc,
		DATE '1900-01-01' AS insert_dt,
		'sa_online_sales' AS source_system,
		'src_online_sales' AS source_entity,
		s.channel_id AS source_id
	FROM sa_online_sales.src_online_sales s
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_channels c
		WHERE c.source_id=s.channel_id
			AND c.channel_desc=s.channel_desc
			AND c.source_system='sa_online_sales'
			AND c.source_entity='src_online_sales');
	-- update for log table:
	v_procedure_name='load_online_channels';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;




-- function to load channels table
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_channels()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new instore source channels 
	INSERT INTO BL_3NF.ce_channels (
		channel_desc,
		insert_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.channel_desc, 'n. a.') AS channel_desc,
		DATE '1900-01-01' AS insert_dt,
		'sa_instore_sales' AS source_system,
		'src_instore_sales' AS source_entity,
		s.channel_id AS source_id
	FROM sa_instore_sales.src_instore_sales s
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_channels c
		WHERE c.source_id=s.channel_id
			AND c.channel_desc=s.channel_desc
			AND c.source_system='sa_instore_sales'
			AND c.source_entity='src_instore_sales');
		-- update for log table:
	v_procedure_name='load_instore_channels';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load age group table
CREATE OR REPLACE PROCEDURE BL_CL.load_online_age_group()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online source age groups
	INSERT INTO BL_3NF.ce_age_groups (
		age_group,
		insert_dt,
	   	update_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.age_group, 'n. a.') AS age_group,
		DATE '1900-01-01' AS insert_dt,
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
			AND ag.age_group=s.age_group
			AND ag.source_system='sa_online_sales'
			AND ag.source_entity='src_online_sales');
	-- update for log table:
	v_procedure_name='load_online_age_group';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load age group table
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_age_group()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new instore source age groups
	INSERT INTO BL_3NF.ce_age_groups (
		age_group,
		insert_dt,
		update_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.age_group, 'n. a.') AS age_group,	
		DATE '1900-01-01' AS insert_dt,
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
			AND ag.age_group=s.age_group
			AND ag.source_system='sa_instore_sales'
			AND ag.source_entity='src_instore_sales');
		-- update for log table:
	v_procedure_name='load_instore_age_group';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load product categories table
CREATE OR REPLACE PROCEDURE BL_CL.load_online_product_categories()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online soure products
	INSERT INTO BL_3NF.ce_product_categories (
		prod_category,
		insert_dt,
		update_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.prod_category, 'n. a.') AS prod_category,
		DATE '1900-01-01' AS insert_dt,
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
			AND pc.prod_category=s.prod_category
			AND pc.source_system='sa_online_sales'
			AND pc.source_entity='src_online_sales');
		v_procedure_name='load_online_product_categories';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- function to load product categories table
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_product_categories()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online soure products
	INSERT INTO BL_3NF.ce_product_categories (
		prod_category,
		insert_dt,
		update_dt,
		source_system,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.prod_category, 'n. a.') AS prod_category,
		DATE '1900-01-01' AS insert_dt,
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
			AND pc.prod_category=s.prod_category
			AND pc.source_system='sa_instore_sales'
			AND pc.source_entity='src_instore_sales');
	v_procedure_name='load_instore_product_categories';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load product subcategories table
CREATE OR REPLACE PROCEDURE BL_CL.load_online_product_subcategories()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online source product subcategories
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
		DATE '1900-01-01' AS insert_dt,
		current_date AS update_dt,
		'sa_online_sales' AS source_system,
		'src_online_sales' AS source_entity,
		s.prod_subcategory_id AS source_id
	FROM sa_online_sales.src_online_sales s
	LEFT JOIN BL_3NF.ce_product_categories pc ON s.prod_category_id = pc.source_id
	WHERE pc.source_system='sa_online_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_product_subcategories ps
		WHERE ps.source_id=s.prod_subcategory_id
			AND ps.prod_subcategory=s.prod_subcategory
			AND pc.source_id=s.prod_category_id
			AND ps.source_system='sa_online_sales'
			AND ps.source_entity='src_online_sales');
		-- update for log table:
	v_procedure_name='load_online_product_subcategories';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- function to load product subcategories table
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_product_subcategories()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online source product subcategories
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
		DATE '1900-01-01' AS insert_dt,
		current_date AS update_dt,
		'sa_instore_sales' AS source_system,
		'src_instore_sales' AS source_entity,
		s.prod_subcategory_id AS source_id
	FROM sa_instore_sales.src_instore_sales s
	LEFT JOIN BL_3NF.ce_product_categories pc ON s.prod_category_id = pc.source_id
	WHERE pc.source_system='sa_instore_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_product_subcategories ps
		WHERE ps.source_id=s.prod_subcategory_id
			AND ps.prod_subcategory=s.prod_subcategory
			AND pc.source_id=s.prod_category_id
			AND ps.source_system='sa_instore_sales'
			AND ps.source_entity='src_instore_sales');
		-- update for log table:
	v_procedure_name='load_instore_product_subcategories';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load product table
CREATE OR REPLACE PROCEDURE BL_CL.load_online_product()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- update if any changes
	UPDATE BL_3NF.ce_products_SCD p
	SET is_active=false,
		end_dt=current_date 
	WHERE p.product_id IN (
		SELECT p.product_id 
		FROM sa_online_sales.src_online_sales s
		LEFT JOIN BL_3NF.ce_products_SCD p ON s.product_id =p.source_id 
		LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
		LEFT JOIN BL_3NF.ce_product_subcategories ps ON s.prod_subcategory_id = ps.source_id
		WHERE s.product_id=p.source_id 
			AND p.product_desc IN (SELECT s2.product
									FROM sa_online_sales.src_online_sales s2
									WHERE s.product<>p.product_desc 
										AND ag.source_id=s.age_group_id
										AND ps.source_id=s.prod_subcategory_id
										AND p.source_system='sa_online_sales')
		AND ag.source_id=s.age_group_id
		AND ps.source_id=s.prod_subcategory_id
		AND p.source_system='sa_online_sales');
	v_procedure_name='update_online_product';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- load new online source products
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
		DATE '1900-01-01' AS start_dt,
		DATE '9999-12-31' AS end_dt,
		TRUE AS is_active,
		DATE '1900-01-01' AS insert_dt,
		current_date AS update_dt,
		'sa_online_sales' AS source_system,
		'src_online_sales' AS source_entity,
		s.product_id AS source_id
	FROM sa_online_sales.src_online_sales s
	LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
	LEFT JOIN BL_3NF.ce_product_subcategories ps ON s.prod_subcategory_id = ps.source_id
	WHERE ag.source_system='sa_online_sales' 
		AND ps.source_system='sa_online_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_products_SCD p
		WHERE p.source_id=s.product_id
			AND p.product_desc =s.product 
			AND ag.source_id=s.age_group_id
			AND ps.source_id=s.prod_subcategory_id
			AND p.source_system='sa_online_sales'
			AND p.source_entity='src_online_sales');
		-- update for log table:
	v_procedure_name='load_online_product';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
   --COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load product table
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_product()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- update if any changes
	UPDATE BL_3NF.ce_products_SCD p
	SET is_active=false,
		end_dt=current_date 
	WHERE p.product_id IN (
		SELECT p.product_id 
		FROM sa_instore_sales.src_instore_sales s
		LEFT JOIN BL_3NF.ce_products_SCD p ON s.product_id =p.source_id 
		LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
		LEFT JOIN BL_3NF.ce_product_subcategories ps ON s.prod_subcategory_id = ps.source_id
		WHERE s.product_id=p.source_id 
			AND p.product_desc IN (SELECT s2.product
									FROM sa_instore_sales.src_instore_sales s2
									WHERE s.product<>p.product_desc 
										AND ag.source_id=s.age_group_id
										AND ps.source_id=s.prod_subcategory_id
										AND p.source_system='sa_instore_sales')
		AND ag.source_id=s.age_group_id
		AND ps.source_id=s.prod_subcategory_id
		AND p.source_system='sa_instore_sales');
	v_procedure_name='update_instore_product';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
-- load new instore source products
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
		DATE '1900-01-01' AS start_dt,
		DATE '9999-12-31' AS end_dt,
		TRUE AS is_active,
		DATE '1900-01-01' AS insert_dt,
		current_date AS update_dt,
		'sa_instore_sales' AS source_system,
		'src_instore_sales' AS source_entity,
		s.product_id AS source_id
	FROM sa_instore_sales.src_instore_sales s
	LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
	LEFT JOIN BL_3NF.ce_product_subcategories ps ON s.prod_subcategory_id = ps.source_id AND ps.source_system='sa_instore_sales' 
	WHERE ag.source_system='sa_instore_sales' 
		AND ps.source_system='sa_instore_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_products_SCD p
		WHERE p.source_id=s.product_id
			AND p.product_desc =s.product 	
			AND ag.source_id=s.age_group_id
			AND ps.source_id=s.prod_subcategory_id
			AND p.source_system='sa_instore_sales'
			AND p.source_entity='src_instore_sales');
	-- update for log table:
	v_procedure_name='load_instore_product';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
   --COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load branches table
CREATE OR REPLACE PROCEDURE BL_CL.load_branches()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new branches
		INSERT INTO BL_3NF.ce_branches (
		branch_name,
		address_id,
		insert_dt,
		update_dt,
		source_system ,
		source_entity,
		source_id)
	SELECT DISTINCT
		COALESCE(s.branch_name, 'n. a.') AS branch_name,
		ad.address_id,
		DATE '1900-01-01' AS insert_dt,
		current_date AS update_dt,
		'sa_instore_sales' AS source_system,
		'src_instore_sales' AS source_entity,
		s.branch_id AS source_id
	FROM sa_instore_sales.src_instore_sales s
	LEFT JOIN BL_3NF.ce_addresses ad ON ad.source_id=s.address_id
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_branches b
		WHERE b.source_id=s.branch_id
			AND b.branch_name=s.branch_name
			AND b.source_system='sa_instore_sales'
			AND b.source_entity='src_instore_sales');
	-- update for log table:
	v_procedure_name='load_branches';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load promo categories table
CREATE OR REPLACE PROCEDURE BL_CL.load_online_promo_categories()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online spurce promotion categories 
	INSERT INTO BL_3NF.ce_promo_categories (
		promo_category,
		insert_dt,
		update_dt,
		source_system ,
		source_entity,
		source_id)
	SELECT DISTINCT
		s.promo_category AS promo_category,
		DATE '1900-01-01' AS insert_dt,
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
			AND pc.promo_category=s.promo_category
			AND pc.source_system='sa_online_sales'
			AND pc.source_entity='src_online_sales');
	-- update for log table:
	v_procedure_name='load_online_promo_categories';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;	
END;
$$ LANGUAGE plpgsql;


-- function to load promo categories table
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_promo_categories()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online spurce promotion categories 
	INSERT INTO BL_3NF.ce_promo_categories (
		promo_category,
		insert_dt,
		update_dt,
		source_system ,
		source_entity,
		source_id)
	SELECT DISTINCT
		s.promo_category AS promo_category,
		DATE '1900-01-01' AS insert_dt,
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
			AND pc.promo_category=s.promo_category
			AND pc.source_system='sa_instore_sales'
			AND pc.source_entity='src_instore_sales');
	-- update for log table:
	v_procedure_name='load_instore_promo_categories';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;	
END;
$$ LANGUAGE plpgsql;



-- function to load promotions table
CREATE OR REPLACE PROCEDURE BL_CL.load_online_promotions()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online source promotions
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
		DATE '1900-01-01' AS insert_dt,
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
	-- update for log table:
	v_procedure_name='load_online_promotions';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;



-- function to load promotions table
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_promotions()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online source promotions
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
		DATE '1900-01-01' AS insert_dt,
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
	-- update for log table:
	v_procedure_name='load_instore_promotions';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- function to load sales personnel table
CREATE OR REPLACE PROCEDURE BL_CL.load_sales_personnel()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new sales personnel
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
		DATE '1900-01-01' AS insert_dt,
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
			AND p.empl_name=s.first_name
			AND p.empl_last_name=s.last_name
			AND p.source_system='sa_instore_sales'
			AND p.source_entity='src_instore_sales');
		-- update for log table:
	v_procedure_name='load_sales_personnel';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- function to load sales table
-- online sales
CREATE OR REPLACE PROCEDURE BL_CL.load_online_sales()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new online sales 
    INSERT INTO BL_3NF.ce_sales (sale_date, 
    							channel_id, 
    							product_id, 
    							customer_id, 
    							branch_id, 
    							employee_id, 
    							promotion_id, 
    							order_quantity, 
    							unit_cost, 
    							unit_price, 
    							insert_dt, 
    							source_system, 
    							source_entity, 
    							source_id)
    SELECT
        d.sale_date,
        d.channel_id,
        d.product_id,
        d.customer_id,
        -1 AS branch_id,
        -1 AS employee_id,
        d.promotion_id,
        d.order_quantity,
        d.unit_cost,
        d.unit_price,
        d.insert_dt,
        d.source_system,
        d.source_entity,
        d.source_id
    FROM (
        SELECT
            date::date AS sale_date,
            cch.channel_id,
            pscd.product_id,
            cc.customer_id,
            cp.promotion_id,
            s.order_quantity::integer AS order_quantity,
            s.unit_cost::decimal(10, 2) AS unit_cost,
            s.unit_price::decimal(10, 2) AS unit_price,
            current_date AS insert_dt,
            'sa_online_sales' AS source_system,
            'src_online_sales' AS source_entity,
            s.transaction_id AS source_id
        FROM sa_online_sales.src_online_sales s
        LEFT JOIN BL_3NF.ce_channels cch ON s.channel_desc = cch.channel_desc
        LEFT JOIN BL_3NF.ce_products_SCD pscd ON s.product_id = pscd.source_id
        LEFT JOIN BL_3NF.ce_customers cc ON s.customer_id = cc.source_id
        LEFT JOIN BL_3NF.ce_promotions cp ON s.promotion_id = cp.source_id
        LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
        LEFT JOIN BL_3NF.ce_product_categories pc ON s.prod_category_id = pc.source_id
        LEFT JOIN BL_3NF.ce_product_subcategories psc ON s.prod_subcategory_id = psc.source_id
        WHERE ag.age_group_id=pscd.age_group_id 
			AND pc.category_id = psc.category_id 
			AND psc.subcategory_id =pscd.prod_subcategory_id 
			AND ag.source_system='sa_online_sales' 
			AND pscd.source_system='sa_online_sales'
			AND pc.source_system='sa_online_sales'
			AND psc.source_system='sa_online_sales'
			AND pscd.is_active = True
		AND NOT EXISTS (
        SELECT 1
        FROM BL_3NF.ce_sales sa
        WHERE sa.source_id = s.transaction_id
			AND sa.source_system = 'sa_online_sales'
            AND sa.source_entity = 'src_online_sales')) d;
   -- update for log table:
	v_procedure_name='load_online_sales';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;	


-- Instore sales data  
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_sales()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
BEGIN
	SELECT current_user INTO v_user_name;
	-- starting insert transaction block
	BEGIN 
	-- load new instore sales      
    INSERT INTO BL_3NF.ce_sales (sale_date, 
    							channel_id, 
    							product_id, 
    							customer_id, 
    							branch_id, 
    							employee_id, 
    							promotion_id, 
    							order_quantity, 
    							unit_cost, 
    							unit_price, 
    							insert_dt, 
    							source_system, 
    							source_entity, 
    							source_id)
    SELECT
        d.sale_date,
        d.channel_id,
        d.product_id,
        '-1' AS customer_id,
        d.branch_id,
        d.employee_id,
        d.promotion_id,
        d.order_quantity,
        d.unit_cost,
        d.unit_price,
        d.insert_dt,
        d.source_system,
        d.source_entity,
        d.source_id
    FROM (
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
            current_date AS insert_dt,
            'sa_instore_sales' AS source_system,
            'src_instore_sales' AS source_entity,
            s.transaction_id AS source_id
        FROM sa_instore_sales.src_instore_sales s
        LEFT JOIN BL_3NF.ce_channels cch ON s.channel_desc = cch.channel_desc
        LEFT JOIN BL_3NF.ce_products_SCD pscd ON s.product_id = pscd.source_id
        LEFT JOIN BL_3NF.ce_branches cb ON s.branch_id = cb.source_id
        LEFT JOIN BL_3NF.ce_sales_personnel sp ON s.employee_id = sp.source_id
        LEFT JOIN BL_3NF.ce_promotions cp ON s.promotion_id = cp.source_id
        LEFT JOIN BL_3NF.ce_age_groups ag ON s.age_group_id = ag.source_id
        LEFT JOIN BL_3NF.ce_product_categories pc ON s.prod_category_id = pc.source_id
        LEFT JOIN BL_3NF.ce_product_subcategories psc ON s.prod_subcategory_id = psc.source_id
        WHERE ag.age_group_id=pscd.age_group_id 
			AND pc.category_id = psc.category_id 
			AND psc.subcategory_id =pscd.prod_subcategory_id 
			AND pscd.source_id=s.product_id  
			AND ag.source_system='sa_instore_sales' 
			AND pscd.source_system='sa_instore_sales'
			AND pc.source_system='sa_instore_sales'
			AND psc.source_system='sa_instore_sales'
			AND pscd.is_active = True
		AND NOT EXISTS (
        SELECT 1
        FROM BL_3NF.ce_sales sa
        WHERE sa.source_id = s.transaction_id
            AND sa.source_system = 'sa_instore_sales'
            AND sa.source_entity = 'src_instore_sales')) d;
           -- update for log table:
	v_procedure_name='load_instore_sales';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
-- if error to rollback and log error:
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	v_outcome := 'Error';
	v_error_code := SQLERRM;
	END;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- commit insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;	



-- Procedure to initialise load data to sales tables
CREATE OR REPLACE PROCEDURE BL_CL.load_full_3NF()
AS $$
BEGIN
	CALL BL_CL.load_online_addresses();
	CALL BL_CL.load_instore_addresses();
	CALL BL_CL.load_genders();
	CALL BL_CL.load_customers();
	CALL BL_CL.load_online_channels();
	CALL BL_CL.load_instore_channels();
	CALL BL_CL.load_online_age_group();
	CALL BL_CL.load_instore_age_group();
	CALL BL_CL.load_online_product_categories();
	CALL BL_CL.load_instore_product_categories();
	CALL BL_CL.load_online_product_subcategories();
	CALL BL_CL.load_instore_product_subcategories();
	CALL BL_CL.load_instore_product();
	CALL BL_CL.load_online_product();
	CALL BL_CL.load_branches();
	CALL BL_CL.load_online_promo_categories();
	CALL BL_CL.load_instore_promo_categories();
	CALL BL_CL.load_online_promotions();
	CALL BL_CL.load_instore_promotions();
	CALL BL_CL.load_sales_personnel();
	CALL BL_CL.load_online_sales();
	CALL BL_CL.load_instore_sales();
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
END;
$$ LANGUAGE plpgsql;


