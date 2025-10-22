 EXEC bronze.load_bronze 

 CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
 BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
	    SET @batch_start_time = GETDATE();
		PRINT '==========================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==========================================';

		PRINT'-------------------------------------------';
		PRINT 'Loading CRM Tables'; 
		PRINT'-------------------------------------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_cust_info'
		TRUNCATE TABLE bronze.crm_cust_info;


		PRINT'>> Inserting Data Into Table: bronze.crm_cust_info'
		 BULK INSERT bronze.crm_cust_info
		FROM 'D:\DataWarehouse\datasets\csv-files\source_cm\cust_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		Print'-----------------'
 
        SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>> Inserting Data Into Table: bronze.crm_prd_info'
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\DataWarehouse\datasets\csv-files\source_cm\prd_info.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		Print'-----------------'


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: crm_sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT'>> Inserting Data Into Table: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\DataWarehouse\datasets\csv-files\source_cm\sales_details.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		Print'-----------------'

		PRINT'-------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT'-------------------------------------------';

		SET @start_time = GETDATE();
		 PRINT'>> Truncating Table: bronze.erp_loc_a101'
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT'>> Inserting Data Into Table:  bronze.erp_loc_a101'
		 BULK INSERT bronze.erp_loc_a101
		FROM 'D:\DataWarehouse\datasets\csv-files\source_erp\loc_a101.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		Print'-----------------'

		SET @start_time = GETDATE();
		PRINT'>> Inserting Data Into Table: bronze.erp_cust_az12'
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>> Inserting Data Into Table: bronze.erp_cust_az12'
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\DataWarehouse\datasets\csv-files\source_erp\cust_az12.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		Print'-----------------'

		SET @start_time = GETDATE();
		PRINT'>> Inserting Data Into Table: bronze.erp_px_cat_g1v2'
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT'>> Inserting Data Into Table:bronze.erp_px_cat_g1v2'
		 BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\DataWarehouse\datasets\csv-files\source_erp\px_cat_g1v2.csv'
		WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
		
		);
		SET @end_time = GETDATE();
		PRINT'>> Load Duration:' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		Print'-----------------'


		Print'========================================'
		SET @batch_end_time = GETDATE();
		PRINT'Loading Bronze Layer is Completed';
		PRINT'- Total Load Duration:' + CAST (DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds'
		Print'========================================'

		 END TRY
		 BEGIN CATCH
		 PRINT '======================================'
		 PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		 PRINT 'Error Message' + ERROR_MESSAGE();
		  PRINT 'Error Message' + CAST( ERROR_NUMBER() AS VARCHAR);
		   PRINT 'Error Message' + CAST( ERROR_STATE() AS VARCHAR);
		 PRINT '======================================'
		 END CATCH

END