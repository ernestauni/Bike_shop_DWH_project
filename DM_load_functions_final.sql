-- granting all privileges in schema for DM layer to user postgres
GRANT ALL PRIVILEGES ON SCHEMA BL_DM TO postgres;


-- loading customers dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_customers()
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
	SELECT 
		cus.customer_id,
		cus.cust_first_name,
		cus.cust_last_name,
		cus.gender_id,
		g.gender_desc,
		cus.email,
		cus.phone_number,
		cus.address_id,
		ad.country,
		ad.city,
		ad.postal_code,
		ad.street,
		ad.building_number,
		cus.insert_dt,
		cus.update_dt,
		cus.source_system,
		cus.source_entity
	FROM BL_3NF.ce_customers cus
	LEFT JOIN BL_3NF.ce_genders g ON g.gender_id =cus.gender_id 
	LEFT JOIN BL_3NF.ce_addresses ad ON ad.address_id =cus.address_id 
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_DM.dim_customers c
		WHERE c.customer_id =cus.customer_id
			AND c.cust_first_name =cus.cust_first_name
			AND c.cust_last_name=cus.cust_last_name
			AND c.email=cus.email
			AND c.phone_number=cus.phone_number 
			AND c.address_id=ad.address_id);
-- update for log table:
	v_procedure_name='load_dim_customers';
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



-- loading channels dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_channels()
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
	-- insert data into the dim_channels table
	INSERT INTO BL_DM.dim_channels (
		channel_id,
		channel_desc,
		insert_dt,
		source_system,
		source_entity) 
	SELECT 
		ch.channel_id,
		ch.channel_desc,
		ch.insert_dt,
		ch.source_system,
		ch.source_entity
	FROM BL_3NF.ce_channels ch
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_DM.dim_channels c
		WHERE c.channel_id=ch.channel_id
			AND c.channel_desc=ch.channel_desc);
	-- update for log table:
	v_procedure_name='load_dim_channels';
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



-- loading branches dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_branches()
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
	SELECT 
		b.branch_id,
		b.branch_name,
		b.address_id,
		ad.country,
		ad.city,
		ad.postal_code,
		ad.street,
		ad.building_number,
		b.insert_dt,
		b.update_dt,
		b.source_system,
		b.source_entity
	FROM BL_3NF.ce_branches b
	LEFT JOIN BL_3NF.ce_addresses ad ON ad.address_id=b.address_id
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_DM.dim_branches br
		WHERE br.branch_id=b.branch_id
			AND br.branch_name=b.branch_name);
	-- update for log table:
	v_procedure_name='load_dim_branches';
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



-- loading promotions dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_promotions()
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
	-- load new promotions
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
	SELECT 
		p.promotion_id,
		p.promo_category_id,
		pc.promo_category,
		p.promo_name,
		p.promo_start_dt,
		p.promo_end_dt,
		p.discount,
		p.insert_dt,
		p.update_dt,
		p.source_system,
		p.source_entity
	FROM BL_3NF.ce_promotions p
	LEFT JOIN  BL_3NF.ce_promo_categories pc ON p.promo_category_id=pc.promo_category_id 
	-- not including null values:
	WHERE pc.source_id IS NOT NULL 
	-- check for existing data to include only new values:
	AND NOT EXISTS (
		SELECT 1
		FROM BL_DM.dim_promotions pr
		WHERE pr.promotion_id =p.promotion_id
			AND pc.promo_category_id =p.promo_category_id);
	-- update for log table:
	v_procedure_name='load_dim_promotions';
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



-- loading sales_personnel dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_sales_personnel()
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
	INSERT INTO BL_DM.dim_sales_personnel (
		employee_id,
		empl_first_name,
		empl_last_name,
		email,
		phone_number,
		insert_dt,
		update_dt,
		source_system,
		source_entity) 
	SELECT 
		p.employee_id,
		p.empl_name,
		p.empl_last_name,
		p.email,
		p.phone_number,
		p.insert_dt,
		p.update_dt,
		p.source_system,
		p.source_entity
	FROM BL_3NF.ce_sales_personnel p
	-- check for existing data to include only new values:
	WHERE NOT EXISTS (
		SELECT 1
		FROM BL_DM.dim_sales_personnel sp
		WHERE p.employee_id=sp.employee_id
			AND p.empl_name =sp.empl_first_name 
			AND p.empl_last_name =sp.empl_last_name);
		-- update for log table:
	v_procedure_name='load_dim_sales_personnel';
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



-- loading products_SCD dimension:
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_products_SCD()
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
	UPDATE BL_DM.dim_products_SCD p
	SET is_active=false,
		end_dt=current_date 
	WHERE p.product_id IN (SELECT p2.product_id 
							FROM BL_3NF.ce_products_scd p2 
							WHERE is_active=false);
	v_procedure_name='update_instore_product';
	v_outcome := 'Success';
	GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
	-- updateing log table:
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
    VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- Perform UPSERT operation using MERGE statement
	MERGE INTO BL_DM.dim_products_SCD AS target
	USING (
		SELECT p.product_id,
				p.age_group_id,
				p.prod_subcategory_id,
				p.product_desc,
				p.start_dt,
				p.end_dt,
				p.is_active,
				p.insert_dt,
				p.update_dt,
				p.source_system,
				p.source_entity,
				sc.prod_subcategory,
				c.category_id,
				c.prod_category,
				ag.age_group 
		FROM BL_3NF.ce_products_scd p
		LEFT JOIN BL_3NF.ce_product_subcategories sc ON sc.subcategory_id =p.prod_subcategory_id 
		LEFT JOIN BL_3NF.ce_product_categories c ON sc.category_id = c.category_id
		LEFT JOIN BL_3NF.ce_age_groups ag ON ag.age_group_id = p.age_group_id) AS s
	ON (target.product_id = s.product_id)
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
	-- update for log table:
	v_procedure_name='load_dim_products_SCD';
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

-- creating load to fact table using partitioning - by year and incremental load
CREATE OR REPLACE PROCEDURE BL_CL.load_fct_sales()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
	v_previous_load_date TIMESTAMP WITH TIME ZONE;
	v_partition_name TEXT;
	v_current_partition TEXT;
	v_partition_bound_start DATE;
	v_partition_bound_end DATE;
	v_sale_date DATE;
	v_partition_detached BOOLEAN; 
BEGIN
	SELECT current_user INTO v_user_name;
  
	-- Starting insert transaction block
	BEGIN
		-- Get the previous load date from the meta table
		SELECT previous_load_date INTO v_previous_load_date
		FROM BL_CL.PRM_MTA_INCREMENTAL_LOAD
		WHERE source_table_name = 'ce_sales';
        
		-- Set a default value for v_previous_load_date if it is NULL
		IF v_previous_load_date IS NULL THEN
			v_previous_load_date := '1900-01-01 00:00:00'::timestamp;
		END IF;
        
		-- Get the target partition based on the year of event_date
		SELECT DISTINCT to_char(event_date, 'YYYY') INTO v_partition_name
		FROM BL_CL.incr_sales;
        
		SELECT DISTINCT (event_date) INTO v_sale_date
		FROM BL_CL.incr_sales;
        
		v_partition_detached := FALSE; -- Initialize the flag as false
        
		IF v_partition_name IS NOT NULL THEN
			v_partition_name := 'fct_sales_' || to_char(v_sale_date, 'YYYY');
            
			-- Detach old partitions before inserting new data
			FOR v_current_partition IN
				SELECT table_name
				FROM information_schema.tables
				WHERE table_name LIKE 'fct_sales_%' AND table_name <> v_partition_name
			LOOP
				v_partition_bound_start := (replace(v_current_partition, 'fct_sales_', '') || '-01-01')::DATE;
				v_partition_bound_end := (v_partition_bound_start + INTERVAL '1 year')::DATE;
                
				IF v_sale_date > v_partition_bound_start AND v_sale_date <= v_partition_bound_end THEN
					EXECUTE 'ALTER TABLE BL_DM.fct_sales DETACH PARTITION ' || 'BL_DM.' || v_current_partition;
					v_partition_detached := TRUE; -- Set the flag to true if any partition is detached
				END IF;
			END LOOP;
            
			-- Load data to DM fact table using the current partition
			EXECUTE 'INSERT INTO BL_DM.' || v_partition_name || ' (
				event_dt_surr_id,
				event_dt,
				channel_id,
				product_id,
				customer_id,
				branch_id,
				employee_id,
				promotion_id,
				Order_Quantity,
				Unit_Cost,
				Unit_Price,
				Final_price,
				Profit,
				Cost,
				Revenue,
  				insert_dt
			) SELECT
				date_surr_id,
				event_date,
				channel_surr_id,
				product_surr_id,
				customer_surr_id,
				branch_surr_id,
				employee_surr_id,
				promotion_surr_id,
				order_quantity,
				unit_cost,
				unit_price,
				final_price,
				profit,
				cost,
				revenue,
				current_date
			FROM BL_CL.incr_sales';
            
			-- Attach the partition back to the main table if it was detached
			IF v_partition_detached THEN
				EXECUTE 'ALTER TABLE BL_DM.fct_sales ATTACH PARTITION ' || 'BL_DM.' || v_partition_name ||
					' FOR VALUES FROM (''' || to_char(v_sale_date, 'YYYY') || '-01-01' || ''') TO (''' || to_char(v_sale_date + INTERVAL '1 year', 'YYYY') || '-01-01' || ''')';
			END IF;
		END IF;
        
		-- Update for log table info
		v_procedure_name = 'load_fct_sales';
		v_outcome = 'Success';
		GET DIAGNOSTICS v_rows_affected = ROW_COUNT;
	EXCEPTION
	-- Rollback the transaction if an error occurred
		WHEN OTHERS THEN
			ROLLBACK;
			-- Raise the exception
 			RAISE;
			v_outcome = 'Error';
			v_error_code = SQLERRM;
	END;
	-- update incremental load meta table
	INSERT INTO BL_CL.PRM_MTA_INCREMENTAL_LOAD (source_table_name,target_table_name,procedure_name,previous_load_date)
	VALUES('BL_3NF.ce_sales','BL_DM.fct_sales','load_fct_sales',CURRENT_TIMESTAMP);
	-- Update the log table
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
	VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- Commit the insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- Procedure to initialise load data to dimention tables
CREATE OR REPLACE PROCEDURE BL_CL.load_dim_tables()
AS $$
BEGIN
	CALL BL_CL.load_dim_customers();
	CALL BL_CL.load_dim_channels();
	CALL BL_CL.load_dim_branches();
	CALL BL_CL.load_dim_promotions();
CALL BL_CL.load_dim_products_SCD();
	CALL BL_CL.load_dim_sales_personnel();
	CALL BL_CL.load_dim_products_SCD();
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
END;
$$ LANGUAGE plpgsql;


INSERT INTO BL_DM.' || v_partition_name || ' (
				event_dt_surr_id,
				event_dt,
				channel_id,
				product_id,
				customer_id,
				branch_id,
				employee_id,
				promotion_id,
				Order_Quantity,
				Unit_Cost,
				Unit_Price,
				Final_price,
				Profit,
				Cost,
				Revenue,
  				insert_dt
			) SELECT
				date_surr_id,
				event_date,
				channel_surr_id,
				product_surr_id,
				customer_surr_id,
				branch_surr_id,
				employee_surr_id,
				promotion_surr_id,
				order_quantity,
				unit_cost,
				unit_price,
				final_price,
				profit,
				cost,
				revenue,
				current_date
			FROM BL_CL.incr_sales;
