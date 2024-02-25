-- 1. Creating schema:
CREATE SCHEMA IF NOT EXISTS BL_3NF;


--2.  Creating each table:

CREATE TABLE IF NOT EXISTS BL_3NF.ce_addresses (
	address_id SERIAL PRIMARY KEY,
	country VARCHAR(20),
	city VARCHAR(30),
	postal_code VARCHAR(6), 
	street VARCHAR(30),
	building_number VARCHAR(10),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));

CREATE TABLE IF NOT EXISTS BL_3NF.ce_genders (
	gender_id SERIAL PRIMARY KEY,
	gender_desc VARCHAR(3),
	insert_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));

CREATE TABLE IF NOT EXISTS BL_3NF.ce_customers (
	customer_id SERIAL PRIMARY KEY,
	cust_first_name VARCHAR(25),
	cust_last_name VARCHAR(35),
	gender_id BIGINT REFERENCES BL_3NF.ce_genders (gender_id),
	email VARCHAR(60),
	phone_number VARCHAR(20),
	address_id BIGINT REFERENCES BL_3NF.ce_addresses (address_id),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));

CREATE TABLE IF NOT EXISTS BL_3NF.ce_channels (
	channel_id SERIAL PRIMARY KEY,
	channel_desc VARCHAR(15),
	insert_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));

CREATE TABLE IF NOT EXISTS BL_3NF.ce_age_groups (
	age_group_id SERIAL PRIMARY KEY,
	age_group VARCHAR(25),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));
	
CREATE TABLE IF NOT EXISTS BL_3NF.ce_product_categories (
	category_id SERIAL PRIMARY KEY,
	prod_category VARCHAR(15),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));

CREATE TABLE IF NOT EXISTS BL_3NF.ce_product_subcategories (
	subcategory_id SERIAL PRIMARY KEY,
	prod_subcategory VARCHAR(50),
	category_id BIGINT REFERENCES BL_3NF.ce_product_categories (category_id),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));


CREATE TABLE IF NOT EXISTS BL_3NF.ce_products_SCD (
	product_id SERIAL PRIMARY KEY,
	age_group_id BIGINT REFERENCES BL_3NF.ce_age_groups (age_group_id),
	prod_subcategory_id BIGINT REFERENCES BL_3NF.ce_product_subcategories (subcategory_id),
	product_desc VARCHAR(50),
	start_dt date,
	end_dt date,
	is_active boolean,
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));


CREATE TABLE IF NOT EXISTS BL_3NF.ce_branches (
	branch_id SERIAL PRIMARY KEY,
	branch_name VARCHAR(25),
	address_id BIGINT REFERENCES BL_3NF.ce_addresses (address_id),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));


CREATE TABLE IF NOT EXISTS BL_3NF.ce_promo_categories (
	promo_category_id SERIAL PRIMARY KEY,
	promo_category VARCHAR(20),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));

CREATE TABLE IF NOT EXISTS BL_3NF.ce_promotions (
	promotion_id SERIAL PRIMARY KEY,
	promo_category_id BIGINT REFERENCES BL_3NF.ce_promo_categories (promo_category_id),
	promo_name VARCHAR(20),
	promo_start_dt date,
	promo_end_dt date,
	discount decimal(10,2),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));


CREATE TABLE IF NOT EXISTS BL_3NF.ce_sales_personnel (
	employee_id SERIAL PRIMARY KEY,
	empl_name VARCHAR(25),
	empl_last_name VARCHAR(35),
	email VARCHAR(40),
	phone_number VARCHAR(13),
	insert_dt date,
	update_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));


CREATE TABLE IF NOT EXISTS BL_3NF.ce_sales (
	sale_date date,
	channel_id BIGINT REFERENCES BL_3NF.ce_channels (channel_id),
	product_id BIGINT REFERENCES BL_3NF.ce_products_SCD (product_id),
	customer_id BIGINT REFERENCES BL_3NF.ce_customers (customer_id),
	branch_id BIGINT REFERENCES BL_3NF.ce_branches (branch_id),
	employee_id BIGINT REFERENCES BL_3NF.ce_sales_personnel (employee_id),
	promotion_id BIGINT REFERENCES BL_3NF.ce_promotions (promotion_id),
	order_quantity BIGINT,
	unit_cost decimal(10,2),
	unit_price decimal(10,2),
	insert_dt date,
	source_system VARCHAR(50),
	source_entity VARCHAR(50),
	source_id VARCHAR(50));
	


