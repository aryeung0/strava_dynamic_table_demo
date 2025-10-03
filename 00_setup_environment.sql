-- ============================================================================
-- Strava Dynamic Tables Demo - Environment Setup
-- ============================================================================
-- This script creates all necessary Snowflake objects for the demo
-- Run this ONCE before executing the notebooks
-- ============================================================================

-- Use ACCOUNTADMIN to create role and grants
USE ROLE ACCOUNTADMIN;

-- ============================================================================
-- 1. CREATE ROLE
-- ============================================================================
CREATE ROLE IF NOT EXISTS STRAVA_DEMO_ADMIN
    COMMENT = 'Role for Strava Dynamic Tables demo';

-- Grant role to current user (adjust as needed)
GRANT ROLE STRAVA_DEMO_ADMIN TO ROLE ACCOUNTADMIN;

-- ============================================================================
-- 2. CREATE WAREHOUSE
-- ============================================================================
CREATE OR REPLACE WAREHOUSE STRAVA_DEMO_WH
    WAREHOUSE_SIZE = XSMALL
    AUTO_SUSPEND = 300
    AUTO_RESUME = TRUE
    INITIALLY_SUSPENDED = FALSE
    COMMENT = 'Warehouse for Strava demo activities';

-- Grant warehouse usage
GRANT USAGE, OPERATE ON WAREHOUSE STRAVA_DEMO_WH TO ROLE STRAVA_DEMO_ADMIN;

-- ============================================================================
-- 3. CREATE DATABASE AND SCHEMAS
-- ============================================================================
CREATE DATABASE IF NOT EXISTS STRAVA_DEMO_SAMPLE
    COMMENT = 'Database for Strava Dynamic Tables demo';

USE DATABASE STRAVA_DEMO_SAMPLE;

-- Create schema for raw data
CREATE SCHEMA IF NOT EXISTS RAW_DATA
    COMMENT = 'Schema for raw activity data';

-- Create schema for Dynamic Tables
CREATE SCHEMA IF NOT EXISTS STRAVA_DYNAMIC_TABLES
    COMMENT = 'Schema for Dynamic Tables processing';

-- ============================================================================
-- 4. GRANT PERMISSIONS TO ROLE
-- ============================================================================
GRANT USAGE ON DATABASE STRAVA_DEMO_SAMPLE TO ROLE STRAVA_DEMO_ADMIN;
GRANT USAGE ON SCHEMA RAW_DATA TO ROLE STRAVA_DEMO_ADMIN;
GRANT USAGE ON SCHEMA STRAVA_DYNAMIC_TABLES TO ROLE STRAVA_DEMO_ADMIN;

-- Grant permissions on RAW_DATA schema
GRANT CREATE TABLE, CREATE VIEW, CREATE DYNAMIC TABLE ON SCHEMA RAW_DATA TO ROLE STRAVA_DEMO_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA RAW_DATA TO ROLE STRAVA_DEMO_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA RAW_DATA TO ROLE STRAVA_DEMO_ADMIN;

-- Grant permissions on STRAVA_DYNAMIC_TABLES schema
GRANT CREATE TABLE, CREATE VIEW, CREATE DYNAMIC TABLE ON SCHEMA STRAVA_DYNAMIC_TABLES TO ROLE STRAVA_DEMO_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA STRAVA_DYNAMIC_TABLES TO ROLE STRAVA_DEMO_ADMIN;
GRANT SELECT, INSERT, UPDATE, DELETE ON FUTURE TABLES IN SCHEMA STRAVA_DYNAMIC_TABLES TO ROLE STRAVA_DEMO_ADMIN;
GRANT SELECT ON ALL DYNAMIC TABLES IN SCHEMA STRAVA_DYNAMIC_TABLES TO ROLE STRAVA_DEMO_ADMIN;
GRANT SELECT ON FUTURE DYNAMIC TABLES IN SCHEMA STRAVA_DYNAMIC_TABLES TO ROLE STRAVA_DEMO_ADMIN;

-- ============================================================================
-- 5. VERIFY SETUP
-- ============================================================================
-- Switch to the demo role
USE ROLE STRAVA_DEMO_ADMIN;
USE WAREHOUSE STRAVA_DEMO_WH;
USE DATABASE STRAVA_DEMO_SAMPLE;
USE SCHEMA RAW_DATA;

SELECT 'Environment setup completed successfully!' as STATUS,
       CURRENT_ROLE() as ROLE,
       CURRENT_WAREHOUSE() as WAREHOUSE,
       CURRENT_DATABASE() as DATABASE,
       CURRENT_SCHEMA() as SCHEMA;

-- ============================================================================
-- Setup Complete! 
-- Next Steps:
-- 1. Open 01_strava_dynamic_tables_demo.ipynb in Snowflake Notebooks
-- 2. Run all cells sequentially to complete the demo (~18 minutes)
-- 3. When done, run 02_cleanup.sql to remove all resources
-- ============================================================================


