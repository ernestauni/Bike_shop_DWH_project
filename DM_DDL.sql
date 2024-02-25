-- creating schema for DM layer
CREATE SCHEMA BL_DM;

-- creating table for each dimension:
CREATE TABLE IF NOT EXISTS BL_DM.dim_customers (
	customer_surr_id SERIAL PRIMARY KEY,
	customer_id BIGINT,
	cust_first_name VARCHAR,
	cust_last_name VARCHAR,
	gender_id INTEGER,
	gender_desc VARCHAR,
	email VARCHAR,
	phone_number VARCHAR,
	address_id INTEGER,
	country VARCHAR,
	city VARCHAR,
	postal_code VARCHAR(5), 
	street VARCHAR(30),
	building_number VARCHAR(10),
	insert_dt date,
	update_dt date,
	source_system VARCHAR,
	source_entity VARCHAR);

	
CREATE TABLE IF NOT EXISTS BL_DM.dim_channels (
	channel_surr_id SERIAL PRIMARY KEY,
	channel_id BIGINT,
	channel_desc VARCHAR(50),
	insert_dt date,
	update_dt date,
	source_system VARCHAR,
	source_entity VARCHAR);


CREATE TABLE IF NOT EXISTS BL_DM.dim_products_SCD (
	product_surr_id SERIAL PRIMARY KEY,
	product_id BIGINT,
	age_group_id INTEGER,
	age_group_desc VARCHAR,
	category_id INTEGER,
	category_desc VARCHAR,
	subcategory_id INTEGER,
	subcategory_desc VARCHAR,
	product_desc VARCHAR,
	start_dt date,
	end_dt date,
	is_active varchar,
	insert_dt date,
	update_dt date,
	source_system VARCHAR,
	source_entity VARCHAR);


CREATE TABLE IF NOT EXISTS BL_DM.dim_branches (
	branch_surr_id SERIAL PRIMARY KEY,
	branch_id BIGINT,
	branch_name VARCHAR,
	address_id INTEGER ,
	country VARCHAR,
	city VARCHAR,
	postal_code VARCHAR(5), 
	street VARCHAR(30),
	building_number VARCHAR(10),
	insert_dt date,
	update_dt date,
	source_system VARCHAR,
	source_entity VARCHAR);


CREATE TABLE IF NOT EXISTS BL_DM.dim_promotions (
	promotion_surr_id SERIAL PRIMARY KEY,
	promotion_id BIGINT,
	promo_category_id INTEGER,
	promo_category_desc VARCHAR,
	promo_name VARCHAR,
	promo_start_dt date,
	promo_end_dt date,
	discount decimal(10,2),
	insert_dt date,
	update_dt date,
	source_system VARCHAR,
	source_entity VARCHAR);

CREATE TABLE IF NOT EXISTS BL_DM.dim_sales_personnel (
	employee_surr_id SERIAL PRIMARY KEY,
	employee_id INTEGER,
	empl_first_name VARCHAR,
	empl_last_name VARCHAR,
	email VARCHAR,
	phone_number VARCHAR(15),
	insert_dt date,
	update_dt date,
	source_system VARCHAR,
	source_entity VARCHAR);


CREATE TABLE IF NOT EXISTS BL_DM.dim_dates (
	date_surr_id SERIAL PRIMARY KEY,
	time_day INTEGER,
	time_mm INTEGER,
	time_year INTEGER,
	time_quarter INTEGER,
	full_date DATE,
	weekday_number INTEGER,
	weekday_name VARCHAR,
	month_name VARCHAR,
	date_mmyyyy VARCHAR,
	is_weekend BOOLEAN,
	source_system VARCHAR,
	source_entity VARCHAR);

-- creating fack sales table
CREATE TABLE IF NOT EXISTS BL_DM.fct_sales (
	event_dt_surr_id BIGINT,
	event_dt DATE,
	channel_id BIGINT,
	product_id BIGINT,
	customer_id BIGINT,
	branch_id BIGINT,
	employee_id BIGINT,
	promotion_id BIGINT,
	Order_Quantity BIGINT,
	Unit_Cost decimal(10,2),
	Unit_Price decimal(10,2),
	Final_price decimal(10,2),
	Profit decimal(10,2),
	Cost decimal(10,2),
	Revenue decimal(10,2),
	insert_dt date);
