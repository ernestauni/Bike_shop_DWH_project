-- creating BL_CL layer
CREATE SCHEMA IF NOT EXISTS BL_CL;


-- creating log table to record load procedures
CREATE TABLE BL_CL.load_log (
    log_id SERIAL PRIMARY KEY,
    log_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    user_name VARCHAR(100),
    procedure_name VARCHAR(100), 	-- load procedure name
    outcome VARCHAR(20),		-- 'success' or'error' as result of load
    error_code VARCHAR(100),		-- error code if any
    rows_affected INTEGER);		-- number of rows updated/loaded

    
-- creating meta table for incremental load
CREATE TABLE BL_CL.PRM_MTA_INCREMENTAL_LOAD (
	id SERIAL PRIMARY KEY,
	source_table_name VARCHAR(100) NOT NULL,
	target_table_name VARCHAR(100) NOT NULL,
	procedure_name VARCHAR(100) NOT NULL,
	previous_load_date TIMESTAMP);


-- creating view for incremental view
CREATE OR REPLACE VIEW BL_CL.incr_sales AS
SELECT d.date_surr_id,
		s.sale_date AS event_date,
		c.channel_surr_id,
		p.product_surr_id,
		cust.customer_surr_id,
		b.branch_surr_id,
		sp.employee_surr_id,
		promo.promotion_surr_id,
		s.order_quantity,
		s.unit_cost,
		s.unit_price,
		s.order_quantity * s.unit_price AS final_price,
		(s.unit_price - s.unit_cost) * s.order_quantity AS profit,
		s.unit_cost * s.order_quantity AS cost,
		s.unit_price * s.order_quantity AS revenue,
		DATE '1900-01-01' AS insert_dt 
FROM BL_3NF.ce_sales s
LEFT JOIN BL_DM.dim_dates d ON s.sale_date = d.full_date
LEFT JOIN BL_DM.dim_channels c ON s.channel_id = c.channel_id
LEFT JOIN BL_DM.dim_products_scd p ON s.product_id = p.product_id
LEFT JOIN BL_DM.dim_customers cust ON s.customer_id = cust.customer_id
LEFT JOIN BL_DM.dim_branches b ON s.branch_id = b.branch_id
LEFT JOIN BL_DM.dim_sales_personnel sp ON s.employee_id = sp.employee_id
LEFT JOIN BL_DM.dim_promotions promo ON s.promotion_id = promo.promotion_id
-- to show data only if inserted after last load
WHERE s.insert_dt > (SELECT MAX (previous_load_date) FROM BL_CL.PRM_MTA_INCREMENTAL_LOAD WHERE source_table_name = 'BL_3NF.ce_sales') 
	OR (SELECT MAX (previous_load_date) FROM BL_CL.PRM_MTA_INCREMENTAL_LOAD WHERE source_table_name = 'BL_3NF.ce_sales') IS NULL
AND NOT EXISTS (SELECT 1
        FROM BL_DM.fct_sales sa);


-- creating partitional tables by year:
CREATE TABLE IF NOT EXISTS BL_DM.fct_sales_2018 PARTITION OF BL_DM.fct_sales FOR VALUES FROM ('2018-01-01') TO ('2019-01-01');
CREATE TABLE IF NOT EXISTS BL_DM.fct_sales_2019 PARTITION OF BL_DM.fct_sales FOR VALUES FROM ('2019-01-01') TO ('2020-01-01');
CREATE TABLE IF NOT EXISTS BL_DM.fct_sales_2020 PARTITION OF BL_DM.fct_sales FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');
CREATE TABLE IF NOT EXISTS BL_DM.fct_sales_2021 PARTITION OF BL_DM.fct_sales FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');
CREATE TABLE IF NOT EXISTS BL_DM.fct_sales_2022 PARTITION OF BL_DM.fct_sales FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');
CREATE TABLE IF NOT EXISTS BL_DM.fct_sales_2023 PARTITION OF BL_DM.fct_sales FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');





    