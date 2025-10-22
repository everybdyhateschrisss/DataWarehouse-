SELECT
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) >1 OR prd_id IS NULL

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost <0 OR prd_cost IS NULL

SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt