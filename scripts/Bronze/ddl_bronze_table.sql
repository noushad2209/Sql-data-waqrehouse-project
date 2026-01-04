/*
Purpose: Create bronze schema tables for CRM and ERP sources.
Notes: Drops existing tables if present, then creates tables in bronze schema.
*/

-- Table: bronze.crm_cust_info
-- Description: Customer master data from CRM (identifiers, keys, first/last names, marital status, gender, create date).

if object_id('bronze.crm_cust_info','U') is NOT NULL
    DROP TABLE bronze.crm_cust_info;

create table bronze.crm_cust_info(
    cst_id int,
    cst_key nvarchar(50),
    cst_fisrtname nvarchar(50),
    cst_lastname nvarchar(50),
    cst_matial_status nvarchar(50),
    cst_gndr nvarchar(50),
    cst_create_date date
);
-- Table: bronze.crm_prd_info
-- Description: Product master data from CRM (id, key, name, cost, product line, start and end dates).
if object_id('bronze.crm_prd_info','U') is NOT NULL
    DROP TABLE bronze.crm_prd_info;

create table bronze.crm_prd_info(
    prd_id int,
    prd_key nvarchar(50),
    prd_nm nvarchar(50),
    prd_cost int,
    prd_line nvarchar(50),
    prd_start_dt datetime,
    prd_end_date DATETIME
);
-- Table: bronze.crm_sales_details
-- Description: Sales transaction details (order number, product key, customer id, order/ship/due dates, sales amount, quantity, price).
if object_id('bronze.crm_sales_details','U') is NOT NULL
    DROP TABLE bronze.crm_sales_details;

create table bronze.crm_sales_details(
    sls_ord_num nvarchar(50),
    sls_prd_key nvarchar(50),
    sls_cust_id int,
    sls_order_dt int,
    sls_ship_date int,
    sls_due_date int,
    sls_sales int,
    sls_qunatity int,
    sls_price INT
);
-- Table: bronze.erp_cust_az12
-- Description: ERP customer extract (customer id, birth date, gender).
if object_id('bronze.erp_cust_az12','U') is NOT NULL
    DROP TABLE bronze.erp_cust_az12;

create table bronze.erp_cust_az12(
    cid nvarchar(50),
    bdate date,
    gen nvarchar(50)
);
-- Table: bronze.erp_loc_a101
-- Description: ERP location mapping (customer id to country).
if object_id('bronze.erp_loc_a101','U') is NOT NULL
    DROP TABLE bronze.erp_loc_a101;

create table bronze.erp_loc_a101(
    cid nvarchar(50),
    cntry nvarchar(50)
);
-- Table: bronze.erp_px_cat_g1v2
-- Description: ERP Product category mapping(Product id and maintenance).
if object_id('bronze.erp_px_cat_g1v2','U') is NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

create table bronze.erp_px_cat_g1v2(
    id nvarchar(50),
    cat nvarchar(50),
    subcat nvarchar(50),
    maintenance nvarchar(50)
);
