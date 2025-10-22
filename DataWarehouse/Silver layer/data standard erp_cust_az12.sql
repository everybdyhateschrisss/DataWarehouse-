SELECT DISTINCT 
bdate
FROM bronze.erp_cust_az12
WHERE bdate< '1924-01-01' OR bdate > GETDATE()

SELECT DISTINCT 
gen,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
     WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	 ELSE 'n/a'
 END AS gen   
FROM bronze.erp_cust_az12