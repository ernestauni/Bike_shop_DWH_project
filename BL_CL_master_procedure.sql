-- Procedure to initialise load data to all layers
CREATE OR REPLACE PROCEDURE BL_CL.master_load_data()
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

	CALL BL_CL.load_dim_customers();
	CALL BL_CL.load_dim_channels();
	CALL BL_CL.load_dim_branches();
	CALL BL_CL.load_dim_promotions();
	CALL BL_CL.load_dim_sales_personnel();
	CALL BL_CL.load_dim_products_SCD();
	
	CALL BL_CL.load_fct_sales();
EXCEPTION
	WHEN OTHERS THEN
		 -- rollback the transaction if error occured
		ROLLBACK;
		-- raise the exception
		RAISE;
	 COMMIT;
END;
$$ LANGUAGE plpgsql;

CALL BL_CL.master_load_data();



SELECT *
FROM bl_3nf.ce_products_scd cps 
WHERE cps.source_id ='prod_10'
AND cps.source_system ='sa_instore_sales';