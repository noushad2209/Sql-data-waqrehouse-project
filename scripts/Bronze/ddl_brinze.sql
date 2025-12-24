/* 
 ============================================================
 DDL Script: Create Bronze Table
 ============================================================
 Script Purpose:
   This Script Creates tables in the Bronze schema, droping existing tables
   if they already exist.
   Run this script to re-define the DDL sctructure of 'bronze' Tables
 ===========================================================
*/

create or alter PROCEDURE bronze.load_bronze AS
BEGIN
        declare @start_time datetime,@end_time datetime, @batch_start_time DATETIME, @batch_end_time datetime ;
        BEGIN TRY

        print '========================';
        print 'Loading Bronze layer';
        print '======================';

        print '--------------------------'
        print 'Loading CRM Tables;'
        print '--------------------------';

        set @batch_start_time=getdate();
        --crm_cust_info
        set @start_time = getdate();

        print '>> Truncating Table: Bronze.crm_cust_info';
        TRUNCATE TABLE bronze.crm_cust_info;

        BULK INSERT bronze.crm_cust_info
        from 'D:\sql couse files by bara\Project files\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            firstrow = 2,
            fieldterminator =',',
            tablock
        );
        set @end_time=GETDATE() 
        print '>> Load Duration'+ cast(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+'Seconds';
        print '---------------------';

        --crm_prd_info
        set @start_time = getdate();
        print '>> Truncating Table: Bronze.crm_prd_info';
        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        from 'D:\sql couse files by bara\Project files\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            firstrow = 2,
            fieldterminator =',',
            tablock
        );
        set @end_time=GETDATE() 
        print '>> Load Duration'+ cast(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+'Seconds';
        print '---------------------';

        --crm_sales_details
        set @start_time = getdate()
        print '>> Truncating Table: Bronze.crm_sales_details';
        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        from 'D:\sql couse files by bara\Project files\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            firstrow = 2,
            fieldterminator =',',
            tablock
        );
        set @end_time=GETDATE() 
        print '>> Load Duration'+ cast(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+'Seconds';
        print '---------------------';

        set @batch_end_time= getdate()
        print '===================================';
        print '>> CRM Load Duration'+ cast(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) as NVARCHAR)+'Seconds';
        print '======================================';
        
        
        --erp_cust_az12
        set @batch_start_time=getdate()
        print '--------------------------';
        print 'Loading ERP Tables;'
        print '--------------------------';

        set @start_time = getdate();
        print '>> Truncating Table: Bronze.erp_cust_az12';

        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        from 'D:\sql couse files by bara\Project files\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
        WITH (
            firstrow = 2,
            fieldterminator =',',
            tablock
        );
        set @end_time=GETDATE() 
        print '>> Load Duration'+ cast(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+'Seconds';
        print '---------------------';

        --erp_loc_a101
        set @start_time = getdate();
        print '>> Truncating Table: Bronze.erp_loc_a101';
        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        from 'D:\sql couse files by bara\Project files\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
        WITH (
            firstrow = 2,
            fieldterminator =',',
            tablock
        );
        set @end_time=GETDATE() 
        print '>> Load Duration'+ cast(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+'Seconds';
        print '---------------------'

        --erp_loc_a101
        set @start_time = getdate();
        print '>> Truncating Table: Bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;

        BULK INSERT bronze.erp_px_cat_g1v2
        from 'D:\sql couse files by bara\Project files\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
        WITH (
            firstrow = 2,
            fieldterminator =',',
            tablock
        );
        set @end_time=GETDATE() 
        print '>> Load Duration'+ cast(DATEDIFF(SECOND,@start_time,@end_time) as NVARCHAR)+'Seconds';
        print '---------------------';

        set @batch_end_time= getdate()
        print '===================================';
        print '>> ERP Load Duration'+ cast(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) as NVARCHAR)+'Seconds';
        print '======================================';
end TRY
BEGIN CATCH
    print '==========================================';
        print 'Error Occured During Loading Bronze Layer';
        PRINT 'Error Neaasage:' + error_message();
        print 'Error message:' + cast(error_number()as nvarchar);
        print 'Error message:' + cast(error_state()as nvarchar);
        print '=============================================';
    end CATCH
END

EXEC bronze.load_bronze;
