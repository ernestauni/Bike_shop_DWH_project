-- function to load address table
CREATE OR REPLACE FUNCTION load_addresses()
RETURNS VOID AS $$
BEGIN
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
END;
$$ LANGUAGE plpgsql;


-- function to load genders table
CREATE OR REPLACE FUNCTION load_genders()
RETURNS VOID AS $$
BEGIN
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
END;
$$ LANGUAGE plpgsql;


-- function to load customers table
CREATE OR REPLACE FUNCTION load_customers()
RETURNS VOID AS $$
BEGIN
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
		DATE '1900-1-1' AS insert_dt,
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
			AND c.source_system='sa_online_sales'
			AND c.source_entity='src_online_sales');
END;
$$ LANGUAGE plpgsql;


-- function to load channels table
CREATE OR REPLACE FUNCTION load_channels()
RETURNS VOID AS $$
BEGIN
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
END;
$$ LANGUAGE plpgsql;


-- function to load age group table
CREATE OR REPLACE FUNCTION load_age_group()
RETURNS VOID AS $$
BEGIN
	-- Online
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
	-- Instore
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
END;
$$ LANGUAGE plpgsql;


-- function to load product categories table
CREATE OR REPLACE FUNCTION load_product_categories()
RETURNS VOID AS $$
BEGIN
	-- Online
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
	-- Instore
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
END;
$$ LANGUAGE plpgsql;


-- function to load product subcategories table
CREATE OR REPLACE FUNCTION load_product_subcategories()
RETURNS VOID AS $$
BEGIN
	-- Online
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
	WHERE pc.source_system='sa_online_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_product_subcategories ps
		WHERE ps.source_id=s.prod_subcategory_id
			AND pc.source_id=s.prod_category_id
			AND ps.source_system='sa_online_sales'
			AND ps.source_entity='src_online_sales');
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
	WHERE pc.source_system='sa_instore_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_product_subcategories ps
		WHERE ps.source_id=s.prod_subcategory_id
			AND pc.source_id=s.prod_category_id
			AND ps.source_system='sa_instore_sales'
			AND ps.source_entity='src_instore_sales');
END;
$$ LANGUAGE plpgsql;


-- function to load product table
CREATE OR REPLACE FUNCTION load_product()
RETURNS VOID AS $$
BEGIN
	-- Online
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
	WHERE ag.source_system='sa_online_sales' 
		AND ps.source_system='sa_online_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_products_SCD p
		WHERE p.source_id=s.product_id
			AND ag.source_id=s.age_group_id
			AND ps.source_id=s.prod_subcategory_id
			AND p.source_system='sa_online_sales'
			AND p.source_entity='src_online_sales');	   
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
	WHERE ag.source_system='sa_instore_sales' 
		AND ps.source_system='sa_instore_sales' AND
	-- check for existing data to include only new values:
	NOT EXISTS (
		SELECT 1
		FROM BL_3NF.ce_products_SCD p
		WHERE p.source_id=s.product_id
			AND ag.source_id=s.age_group_id
			AND ps.source_id=s.prod_subcategory_id
			AND p.source_system='sa_instore_sales'
			AND p.source_entity='src_instore_sales');
END;
$$ LANGUAGE plpgsql;


-- function to load branches table
CREATE OR REPLACE FUNCTION load_branches()
RETURNS VOID AS $$
BEGIN
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
		DATE '1900-1-1' AS insert_dt,
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
			AND b.source_system='sa_instore_sales'
			AND b.source_entity='src_instore_sales');
END;
$$ LANGUAGE plpgsql;


-- function to load promo categories table
CREATE OR REPLACE FUNCTION load_promo_categories()
RETURNS VOID AS $$
BEGIN
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
END;
$$ LANGUAGE plpgsql;


-- function to load promotions table
CREATE OR REPLACE FUNCTION load_promotions()
RETURNS VOID AS $$
BEGIN
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
END;
$$ LANGUAGE plpgsql;


-- function to load sales personnel table
CREATE OR REPLACE FUNCTION load_sales_personnel()
RETURNS VOID AS $$
BEGIN
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
END;
$$ LANGUAGE plpgsql;



-- function to load sales table
-- online sales
CREATE OR REPLACE FUNCTION load_online_sales()
RETURNS VOID AS $$
BEGIN
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
            DATE '1900-1-1' AS insert_dt,
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
		AND NOT EXISTS (
        SELECT 1
        FROM BL_3NF.ce_sales sa
        WHERE sa.source_id = s.transaction_id
            AND sa.source_system = 'sa_online_sales'
            AND sa.source_entity = 'src_online_sales')) d;	
END;
$$ LANGUAGE plpgsql;	


SELECT load_online_sales();
-- Instore sales data  
CREATE OR REPLACE FUNCTION load_instore_sales()
RETURNS VOID AS $$
BEGIN           
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
            DATE '1900-1-1' AS insert_dt,
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
			AND ag.source_system='sa_instore_sales' 
			AND pscd.source_system='sa_instore_sales'
			AND pc.source_system='sa_instore_sales'
			AND psc.source_system='sa_instore_sales'
		AND NOT EXISTS (
        SELECT 1
        FROM BL_3NF.ce_sales sa
        WHERE sa.source_id = s.transaction_id
            AND sa.source_system = 'sa_instore_sales'
            AND sa.source_entity = 'src_instore_sales')) d;
END;
$$ LANGUAGE plpgsql;	



-- create log_table
CREATE TABLE IF NOT EXISTS bl_3nf.log_table (
    log_id SERIAL PRIMARY KEY,
    log_date TIMESTAMP,
    procedure_name VARCHAR(100),
    user_name VARCHAR(100));

-- create logging procedure
CREATE OR REPLACE PROCEDURE bl_3nf.log_query_execution(
    p_procedure_name VARCHAR(100),
    p_user_name VARCHAR(100))
AS $$
BEGIN
    INSERT INTO bl_3nf.log_table (log_date, procedure_name, user_name)
    VALUES (current_timestamp, p_procedure_name, p_user_name);
END;
$$ LANGUAGE plpgsql;



-- Procedure to initialise all load to 3NF functions
CREATE OR REPLACE PROCEDURE bl_3nf.load_BL_3NF_layer()
AS $$
BEGIN
	PERFORM load_addresses();
	PERFORM load_genders();
	PERFORM load_customers();
	PERFORM load_channels();
	PERFORM load_age_group();
	PERFORM load_product_categories();
	PERFORM load_product_subcategories();
	PERFORM load_product();
	PERFORM load_branches();
	PERFORM load_promo_categories();
	PERFORM load_promotions();
	PERFORM load_sales_personnel();
	CALL bl_3nf.log_query_execution('load_BL_3NF_layer', current_user::VARCHAR(100));
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
END;
$$ LANGUAGE plpgsql;


CALL bl_3nf.load_BL_3NF_layer();


-- Procedure to initialise load data to sales tables
CREATE OR REPLACE PROCEDURE bl_3nf.load_sales_data()
AS $$
BEGIN
	
	PERFORM load_online_sales();
	PERFORM load_instore_sales();
	CALL bl_3nf.log_query_execution('load_sales_data', current_user::VARCHAR(100));
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
END;
$$ LANGUAGE plpgsql;


CALL bl_3nf.load_sales_data();

