
-- =============================================================
-- Purpose: Create 'silver' schema tables used to store CRM and ERP source extracts.
--
-- WARNINGS:
--   * This script will DROP each table if it already exists and then re-create it.
--     Running it will DELETE existing data in those tables. Do NOT run this against
--     production systems without backups and approval.
--   * Several column names appear to contain typos (for example: `cst_fisrtname`,
--     `cst_matial_status`, `sls_qunatity`). Correcting them requires careful
--     migration planning—do not rename columns in-place in production without a plan.
--   * The script intentionally does not define primary keys, foreign keys, or
--     indexes. Add constraints and proper data types (e.g., DECIMAL for money) before
--     using in production.
--
-- NOTES:
--   - Each table includes a `dwh_create_date` column with DEFAULT GETDATE() to
--     capture ingestion timestamp.
--   - Recommended workflow: run and validate in dev/staging, add migrations and
--     constraints, then apply changes to production.
-- =============================================================

-- Ensure table is dropped if it already exists (safe re-create)
if object_id('silver.crm_cust_info','U') is NOT NULL
    DROP TABLE silver.crm_cust_info;

-- Create customer information table in `silver` schema
create table silver.crm_cust_info(
    cst_id int,
    cst_key nvarchar(50),
    cst_fisrtname nvarchar(50),
    cst_lastname nvarchar(50),
    cst_matial_status nvarchar(50),
    cst_gndr nvarchar(50),
    cst_create_date date,
    dwh_create_date datetime2 DEFAULT GETDATE()
);
-- Ensure table is dropped if it already exists (safe re-create)
if object_id('silver.crm_prd_info','U') is NOT NULL
    DROP TABLE silver.crm_prd_info;

-- Create product information table in `silver` schema
create table silver.crm_prd_info(
    prd_id int,
    cat_id nvarchar(50),
    prd_key nvarchar(50),
    prd_nm nvarchar(50),
    prd_cost int,
    prd_line nvarchar(50),
    prd_start_dt date,
    prd_end_date DATE,
    dwh_create_date datetime2 DEFAULT GETDATE()

);
-- Ensure table is dropped if it already exists (safe re-create)
if object_id('silver.crm_sales_details','U') is NOT NULL
    DROP TABLE silver.crm_sales_details;

-- Create sales transaction/details table in `silver` schema
create table silver.crm_sales_details(
    sls_ord_num nvarchar(50),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt date,
    sls_ship_date date,
    sls_due_date date,
    sls_sales int,
    sls_qunatity int,
    sls_price INT,
    dwh_create_date datetime2 DEFAULT GETDATE()
);
-- Ensure table is dropped if it already exists (safe re-create)
if object_id('silver.erp_cust_az12','U') is NOT NULL
    DROP TABLE silver.erp_cust_az12;

-- ERP customer extract (AZ12)
create table silver.erp_cust_az12(
    cid nvarchar(50),
    bdate date,
    gen nvarchar(50),
    dwh_create_date datetime2 DEFAULT GETDATE()
);
-- Ensure table is dropped if it already exists (safe re-create)
if object_id('silver.erp_loc_a101','U') is NOT NULL
    DROP TABLE silver.erp_loc_a101;

-- ERP location extract (A101)
create table silver.erp_loc_a101(
    cid nvarchar(50),
    cntry nvarchar(50),
    dwh_create_date datetime2 DEFAULT GETDATE()
);
-- Ensure table is dropped if it already exists (safe re-create)
if object_id('silver.erp_px_cat_g1v2','U') is NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;

-- ERP price/category classification (PX category)
create table silver.erp_px_cat_g1v2(
    id nvarchar(50),
    cat nvarchar(50),
    subcat nvarchar(50),
    maintenance nvarchar(50),
    dwh_create_date datetime2 DEFAULT GETDATE()
);
