-- it is not possible to load data directly into the 3NF layer, because there are data cleaning and transformation work to be done and due to volume and complexity
-- with 3NF model it would be unefficient

CREATE EXTENSION file_fdw;
CREATE SERVER bike_shop_sales FOREIGN DATA WRAPPER file_fdw;

-- creating 1) schema; 2) external table; 3) source table for online sales:

--1) schema
CREATE SCHEMA IF NOT EXISTS sa_online_sales;

-- 2) external table
TRUNCATE sa_online_sales.ext_online_sales;
CREATE FOREIGN TABLE IF NOT EXISTS sa_online_sales.ext_online_sales (
	date VARCHAR(500),
	channel_id VARCHAR(500),
	channel_desc VARCHAR(500),
	product_id VARCHAR(500),
	age_group_id VARCHAR(500),
	age_group VARCHAR(500),
	prod_category_id VARCHAR(500),
	prod_category VARCHAR(500),
	prod_subcategory_id VARCHAR(500),
	prod_subcategory VARCHAR(500),
	product VARCHAR(500),
	customer_id VARCHAR(500),
	first_name VARCHAR(500),
	last_name VARCHAR(500),
	gender_id VARCHAR(500),
	gender VARCHAR(500),
	phone_number VARCHAR(500),
	email VARCHAR(500),
	address_id VARCHAR(500),
	country VARCHAR(500),
	city VARCHAR(500),
	postal_code VARCHAR(500),
	street VARCHAR(500),
	building_number VARCHAR(500),
	promotion_id VARCHAR(500),
	promo_category_id VARCHAR(500),
	promo_category VARCHAR(500),
	promo_desc VARCHAR(500),
	promo_start_date VARCHAR(500),
	promo_end_date VARCHAR(500),
	discount VARCHAR(500),
	transaction_id VARCHAR(500),
	order_quantity VARCHAR(500),
	unit_cost VARCHAR(500),
	unit_price VARCHAR(500)
) SERVER bike_shop_sales
OPTIONS (filename 'C:\Program Files\PostgreSQL\15\bin\Database\bikes_store_online_sales.csv',
		format 'csv',
		HEADER 'true',
		ENCODING 'UTF8');
COMMIT;


-- 3) source table

CREATE TABLE IF NOT EXISTS sa_online_sales.src_online_sales (
	date VARCHAR(500),
	channel_id VARCHAR(500),
	channel_desc VARCHAR(500),
	product_id VARCHAR(500),
	age_group_id VARCHAR(500),
	age_group VARCHAR(500),
	prod_category_id VARCHAR(500),
	prod_category VARCHAR(500),
	prod_subcategory_id VARCHAR(500),
	prod_subcategory VARCHAR(500),
	product VARCHAR(500),
	customer_id VARCHAR(500),
	first_name VARCHAR(500),
	last_name VARCHAR(500),
	gender_id VARCHAR(500),
	gender VARCHAR(500),
	phone_number VARCHAR(500),
	email VARCHAR(500),
	address_id VARCHAR(500),
	country VARCHAR(500),
	city VARCHAR(500),
	postal_code VARCHAR(500),
	street VARCHAR(500),
	building_number VARCHAR(500),
	promotion_id VARCHAR(500),
	promo_category_id VARCHAR(500),
	promo_category VARCHAR(500),
	promo_desc VARCHAR(500),
	promo_start_date VARCHAR(500),
	promo_end_date VARCHAR(500),
	discount VARCHAR(500),
	transaction_id VARCHAR(500),
	order_quantity VARCHAR(500),
	unit_cost VARCHAR(500),
	unit_price VARCHAR(500));

TRUNCATE sa_online_sales.src_online_sales;
INSERT INTO sa_online_sales.src_online_sales
SELECT * FROM sa_online_sales.ext_online_sales;
COMMIT;

-- creating 1) schema; 2) external table; 3) source table for in-store sales:

--1) schema

CREATE SCHEMA IF NOT EXISTS sa_instore_sales;

-- 2) external table

CREATE FOREIGN TABLE IF NOT EXISTS sa_instore_sales.ext_instore_sales (
	date VARCHAR(500),
	channel_id VARCHAR(500),
	channel_desc VARCHAR(500),
	product_id VARCHAR(500),
	age_group_id VARCHAR(500),
	age_group VARCHAR(500),
	prod_category_id VARCHAR(500),
	prod_category VARCHAR(500),
	prod_subcategory_id VARCHAR(500),
	prod_subcategory VARCHAR(500),
	product VARCHAR(500),
	branch_id VARCHAR(500),
	branch_name VARCHAR(500),
	address_id VARCHAR(500),
	country VARCHAR(500),
	city VARCHAR(500),
	postal_code VARCHAR(500),
	street VARCHAR(500),
	building_number VARCHAR(500),
	employee_id VARCHAR(500),
	first_name VARCHAR(500),
	last_name VARCHAR(500),
	email VARCHAR(500),
	phone_number VARCHAR(500),
	promotion_id VARCHAR(500),
	promo_category_id VARCHAR(500),
	promo_category VARCHAR(500),
	promo_desc VARCHAR(500),
	promo_start_date VARCHAR(500),
	promo_end_date VARCHAR(500),
	discount VARCHAR(500),
	transaction_id VARCHAR(500),
	order_quantity VARCHAR(500),
	unit_cost VARCHAR(500),
	unit_price VARCHAR(500)
  ) SERVER bike_shop_sales
OPTIONS ( filename 'C:\Program Files\PostgreSQL\15\bin\Database\bikes_store_instore_sales.csv', 
		format 'csv',
		HEADER 'true',
		ENCODING 'UTF8');


-- 3) source table

CREATE TABLE IF NOT EXISTS sa_instore_sales.src_instore_sales (
	date VARCHAR(500),
	channel_id VARCHAR(500),
	channel_desc VARCHAR(500),
	product_id VARCHAR(500),
	age_group_id VARCHAR(500),
	age_group VARCHAR(500),
	prod_category_id VARCHAR(500),
	prod_category VARCHAR(500),
	prod_subcategory_id VARCHAR(500),
	prod_subcategory VARCHAR(500),
	product VARCHAR(500),
	branch_id VARCHAR(500),
	branch_name VARCHAR(500),
	address_id VARCHAR(500),
	country VARCHAR(500),
	city VARCHAR(500),
	postal_code VARCHAR(500),
	street VARCHAR(500),
	building_number VARCHAR(500),
	employee_id VARCHAR(500),
	first_name VARCHAR(500),
	last_name VARCHAR(500),
	email VARCHAR(500),
	phone_number VARCHAR(500),
	promotion_id VARCHAR(500),
	promo_category_id VARCHAR(500),
	promo_category VARCHAR(500),
	promo_desc VARCHAR(500),
	promo_start_date VARCHAR(500),
	promo_end_date VARCHAR(500),
	discount VARCHAR(500),
	transaction_id VARCHAR(500),
	order_quantity VARCHAR(500),
	unit_cost VARCHAR(500),
	unit_price VARCHAR(500));


TRUNCATE sa_instore_sales.src_instore_sales;
INSERT INTO  sa_instore_sales.src_instore_sales
SELECT * FROM sa_instore_sales.ext_instore_sales;
COMMIT;

