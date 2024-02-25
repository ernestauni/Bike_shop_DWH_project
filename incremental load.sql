-- creating load to fact table using partitioning - by year and incremental load
CREATE OR REPLACE PROCEDURE BL_CL.load_instore_sales()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
	v_previous_load_date TIMESTAMP WITH TIME ZONE;
	v_sale_date DATE;
BEGIN
	SELECT current_user INTO v_user_name;
  
	-- Starting insert transaction block
	BEGIN
		-- Get the previous load date from the meta table
		SELECT previous_load_date INTO v_previous_load_date
		FROM BL_CL.PRM_MTA_INCREMENTAL_LOAD
		WHERE source_table_name = 'src_instore_sales';
                   
			-- Load data to DM fact table using the current partition
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
        sale_date,
        channel_id,
        product_id,
        '-1' AS customer_id,
        branch_id,
        employee_id,
        promotion_id,
        order_quantity,
        unit_cost,
        unit_price,
        insert_dt,
        source_system,
        source_entity,
        source_id
			FROM BL_CL.incr_sales_instore;
                   
		-- Update for log table info
		v_procedure_name = 'load_instore_sales';
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
	VALUES('src_instore_sales','BL_DM.ce_sales','load_instore_sales',CURRENT_TIMESTAMP);
	-- Update the log table
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
	VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- Commit the insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;

SELECT COUNT(*)
FROM BL_CL.incr_sales_instore;


COPY BL_3NF.ce_sales (sale_date, 
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
FROM 'C:\Program Files\PostgreSQL\15\bin\Database\load3.csv' CSV HEADER ENCODING 'UTF8';

Truncate BL_3NF.ce_sales;




-- creating load to fact table using partitioning - by year and incremental load
CREATE OR REPLACE PROCEDURE BL_CL.load_online_sales()
AS $$
DECLARE
	v_user_name VARCHAR(100);
	v_procedure_name VARCHAR(100);
	v_outcome VARCHAR(20);
	v_error_code VARCHAR(100);
	v_rows_affected INTEGER;
	v_previous_load_date TIMESTAMP WITH TIME ZONE;
	v_sale_date DATE;
BEGIN
	SELECT current_user INTO v_user_name;
  
	-- Starting insert transaction block
	BEGIN
		-- Get the previous load date from the meta table
		SELECT previous_load_date INTO v_previous_load_date
		FROM BL_CL.PRM_MTA_INCREMENTAL_LOAD
		WHERE source_table_name = 'src_online_sales';
                   
			-- Load data to DM fact table using the current partition
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
        sale_date,
        channel_id,
        product_id,
        customer_id,
        -1 AS branch_id,
        -1 AS employee_id,
        promotion_id,
        order_quantity,
        unit_cost,
        unit_price,
        insert_dt,
        source_system,
        source_entity,
        source_id
			FROM BL_CL.incr_sales_online;
                   
		-- Update for log table info
		v_procedure_name = 'load_online_sales';
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
	VALUES('src_online_sales','BL_DM.ce_sales','load_online_sales',CURRENT_TIMESTAMP);
	-- Update the log table
	INSERT INTO BL_CL.load_log (user_name, procedure_name, outcome, error_code, rows_affected)
	VALUES (v_user_name, v_procedure_name, v_outcome, v_error_code, v_rows_affected);
	-- Commit the insert transactions
	--COMMIT;
END;
$$ LANGUAGE plpgsql;


-- Instore sales data  
CREATE OR REPLACE PROCEDURE BL_CL.load_fct_sales()
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
    INSERT INTO BL_DM.fct_sales(
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
				insert_dt
			FROM BL_CL.incr_sales;
           -- update for log table:
	v_procedure_name='load_fct_sales';
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


-- creating view for incremental view
CREATE OR REPLACE VIEW BL_CL.incr_sales_online AS
SELECT    DISTINCT date::date AS sale_date,
            cch.channel_id,
            pscd.product_id,
            cc.customer_id,
            cp.promotion_id,
            s.order_quantity::integer AS order_quantity,
            s.unit_cost::decimal(10, 2) AS unit_cost,
            s.unit_price::decimal(10, 2) AS unit_price,
            DATE '1900-01-01' AS insert_dt,
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
        LEFT JOIN BL_3NF.ce_addresses addr ON cc.address_id =addr.address_id 
        LEFT JOIN bl_3nf.ce_genders cg ON cg.gender_id =cc.gender_id 
        WHERE ag.age_group_id=pscd.age_group_id 
        	AND pc.category_id = psc.category_id 
			AND psc.subcategory_id =pscd.prod_subcategory_id 
			AND cch.source_system='sa_online_sales' 
			AND addr.source_id =s.address_id 
			AND cg.source_id =s.gender_id  
			AND ag.source_system='sa_online_sales' 
			AND pscd.source_system='sa_online_sales'
			AND pc.source_system='sa_online_sales'
			AND psc.source_system='sa_online_sales'
			AND pscd.is_active = True 
			AND NOT EXISTS (
        SELECT 1
        FROM BL_3NF.ce_sales2 sa
        WHERE sa.source_id = s.transaction_id
			AND sa.source_system = 'sa_online_sales'
            AND sa.source_entity = 'src_online_sales');


-- creating view for incremental view
CREATE OR REPLACE VIEW BL_CL.incr_sales_instore AS
SELECT      date::date AS sale_date,
            cch.channel_id,
            pscd.product_id,
            cb.branch_id,
            sp.employee_id,
            cp.promotion_id,
            s.order_quantity::integer AS order_quantity,
            s.unit_cost::decimal(10, 2) AS unit_cost,
            s.unit_price::decimal(10, 2) AS unit_price,
            DATE '1900-01-01' AS insert_dt,
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
			AND pscd.is_active = True AND NOT EXISTS (
        SELECT 1
        FROM BL_3NF.ce_sales sa
        WHERE sa.source_id = s.transaction_id
            AND sa.source_system = 'sa_instore_sales'
            AND sa.source_entity = 'src_instore_sales');
		

CALL BL_CL.load_instore_sales();
CALL BL_CL.load_online_sales();


