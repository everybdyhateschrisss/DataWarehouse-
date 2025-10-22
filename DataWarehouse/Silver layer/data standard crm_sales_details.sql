
SELECT 
NULLIF(sls_ship_dt, 0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0 
OR LEN(sls_ship_dt) !=8
OR sls_ship_dt > 20500101
OR sls_ship_dt < 19000101

SELECT
*

FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt 



SELECT DISTINCT
sls_sales AS old_sls_sales,
sls_quantity,
sls_price AS old_sls_price,

CASE WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price)
         THEN sls_quantity * ABS(sls_price)
     ELSE sls_sales 
END AS sls_sales,

CASE WHEN  sls_price IS NULL OR sls_price <= 0
       THEN sls_sales / NULLIF(sls_quantity,0)
	 ELSE sls_price
END AS sls_price

FROM bronze.crm_sales_details




