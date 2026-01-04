-- =============================================================
-- Purpose: Populate `silver.crm_cust_info` from `bronze.crm_cust_info`.
--
-- WARNINGS:
--   * This script performs INSERTs into the `silver` table and relies on a
--     de-duplication step (ROW_NUMBER()). Running this multiple times may produce
--     duplicate rows unless the target table has constraints or you convert this
--     to a MERGE/UPSERT pattern.
-- NOTES:
--   - This script keeps the most recent record per `cst_id` by using ROW_NUMBER()
--     partitioned by `cst_id` and ordered by `cst_create_date DESC` (flag = 1).
--   - `dwh_create_date` is not set here; ingestion timestamp is captured on table
--     creation via DEFAULT GETDATE() in the target schema.
-- =============================================================

insert into silver.crm_cust_info(
	cst_id,
	cst_key,
	cst_fisrtname,
	cst_lastname,
	cst_matial_status,
	cst_gndr,
	cst_create_date
)
select
cst_id, -- pass through id
cst_key, -- pass through key
trim(cst_fisrtname) as cst_fisrtname, -- trim whitespace from first name
trim(cst_lastname) as cst_lastname, -- trim whitespace from last name
case cst_matial_status when 
	upper(trim('S')) then  'Single'
	when upper(trim('M')) then  'Married'
	else 'n/a'
end as cst_matial_status,
case cst_gndr when
	upper(Trim('M')) then 'Male'
	when upper(trim('F')) then 'Female'
	else 'n/a'
end as cst_gndr,
cst_create_date
from(
    select *,
    row_number() over(partition by cst_id order by cst_create_date desc) as flag -- keep latest record per cst_id
    from bronze.crm_cust_info 
)t where flag=1 and cst_id is not null -- select only latest non-null ids


--select * from silver.crm_cust_info
