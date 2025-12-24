/*
 ============================================================================
 Create Database and Schema
 ============================================================================
 Script purpose
 ----------------------------------------------------------------------------
    This script drops and recreates a SQL Server database named "Datawarehouse",
    then creates three schemas inside it: bronze, silver and gold.

WARNING: 
 ----------------------------------------------------------------------------
    - THIS SCRIPT WILL DROP the 'Datawarehouse' DATABASE and PERMANENTLY DELETE ALL DATA.
    - DO NOT RUN ON PRODUCTION — BACKUP FIRST and confirm the target instance before 
      executing.
 */

use master;
GO
--Drop and recreate the 'Datawarehouse' datbase
IF EXISTS(select 1 from sys.databases where name = 'Datawarehouse')
BEGIN
    alter DATABASE datawarehouse set single_user with ROLLBACK IMMEDIATE;
    DROP DATABASE Datawarehouse;
END;
GO

--Creating the 'Datawarehouse' Databases
create DATABASE Datawarehouse;
go

use Datawarehouse;
GO

--Creating schemas

create schema bronze;   -- bronze schema
GO
create schema silver;   -- silver schema
GO
create schema gold;     -- gold schema
GO
