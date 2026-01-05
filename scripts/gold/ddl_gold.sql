/*
=====================================================================================
DDL Script: Create Gold views
=====================================================================================
Script Purpose:
   This script creates views fro the gold ;ayer in the data warehouse.
   The Gold layerbrepresents the final dimension and fact taables (Satr shema)

   Each view performs transformations and combines data from the Silver layer
   to produce a clean, enriched, and business-ready dataset.
Usage:
  - These views can be queried directly for the analytics and reporting.
======================================================================================
*/

-- ===================================================================================
-- Create Dimension: gold.dim_customers
-- ===================================================================================


if OBJECT_ID('gold.dim_customers','v') is not null
   drop view gold.dim_customers;
GO

create view gold.dim_customers as 
select 
	ROW_NUMBER() over(order by ci.cst_id) as Customer_primary_key,
	ci.cst_id as customer_id,
	ci.cst_key as customer_key,
	ci.cst_fisrtname as first_name,
	ci.cst_lastname as last_name,
	ci.cst_matial_status as marital_status,
	case when ci.cst_gndr !='n/a' then ci.cst_gndr
	else isnull(ci.cst_gndr,'n/a')
	end as gender,
	ci.cst_create_date as create_date,
	ce.bdate as birstdate,
	cl.cntry as country
from silver.crm_cust_info as ci
left join silver.erp_cust_az12 as ce
on	 ce.cid = ci.cst_key
left join silver.erp_loc_a101 as cl
on	 cl.cid = ci.cst_key

if OBJECT_ID('gold.dim_products','v') is not null
   drop view gold.dim_products;
GO

create view gold.dim_products as 
select 
	ROW_NUMBER() over(order by prd_id) as product_key,
	pd.prd_id as product_id,
	pd.prd_key as product_number,
	pd.prd_nm as product_name,
	pd.cat_id as category_id,
	pm.cat as category,
	pm.subcat as sub_category,
	pm.maintenance,
	pd.prd_line as product_line,
	pd.prd_cost as product_cost,
	pd.prd_start_dt as product_start_date
from silver.crm_prd_info as pd
left join silver.erp_px_cat_g1v2 as pm
on	pd.cat_id= pm.id
where pd.prd_end_date is NULL -- Filterout the Hisorical data

if OBJECT_ID('gold.fact_sales','v') is not null
   drop view gold.fact_sales;
GO

create view gold.fact_sales as 
SELECT sls_ord_num,
      dp.product_key,
      dc.Customer_primary_key as customer_key,
      sls_order_dt as order_date,
      sls_ship_date as Shipping_date,
      sls_due_date as due_date,
      sls_sales as sales,
      sls_qunatity as qunatity,
      sls_price as price
      
FROM Datawarehouse.silver.crm_sales_details as sd
left join gold.dim_products as dp
on  sd.sls_prd_key = dp.product_number
left join gold.dim_customers as dc
on  sd.sls_cust_id = dc.customer_id
