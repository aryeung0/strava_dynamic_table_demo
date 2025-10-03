-- ============================================================================
-- Strava Dynamic Tables Demo - Cleanup Script
-- ============================================================================
-- This script removes ALL resources created by the demo
-- Run this to completely clean up the environment when you're done
-- ============================================================================
-- WARNING: This will permanently delete:
--   - Dynamic Tables (activity_intelligence, athlete_performance_dashboard)
--   - Source table (ACTIVITIES)
--   - Schemas (RAW_DATA, STRAVA_DYNAMIC_TABLES)
--   - Database (STRAVA_DEMO_SAMPLE)
--   - Warehouse (STRAVA_DEMO_WH)
--   - Role (STRAVA_DEMO_ADMIN)
-- ============================================================================

-- Use ACCOUNTADMIN to drop role and grants
USE ROLE ACCOUNTADMIN;

-- ============================================================================
-- 1. DROP DYNAMIC TABLES
-- ============================================================================
-- Drop Dynamic Tables first (dependencies must be removed before schemas)
USE DATABASE STRAVA_DEMO_SAMPLE;
USE SCHEMA STRAVA_DYNAMIC_TABLES;

DROP DYNAMIC TABLE IF EXISTS ATHLETE_PERFORMANCE_DASHBOARD;
DROP DYNAMIC TABLE IF EXISTS ACTIVITY_INTELLIGENCE;

SELECT 'Dynamic Tables dropped' as STATUS;

-- ============================================================================
-- 2. DROP SOURCE TABLE
-- ============================================================================
USE SCHEMA RAW_DATA;

DROP TABLE IF EXISTS ACTIVITIES;

SELECT 'Source tables dropped' as STATUS;

-- ============================================================================
-- 3. DROP SCHEMAS
-- ============================================================================
USE DATABASE STRAVA_DEMO_SAMPLE;

DROP SCHEMA IF EXISTS STRAVA_DYNAMIC_TABLES;
DROP SCHEMA IF EXISTS RAW_DATA;

SELECT 'Schemas dropped' as STATUS;

-- ============================================================================
-- 4. DROP DATABASE
-- ============================================================================
DROP DATABASE IF EXISTS STRAVA_DEMO_SAMPLE;

SELECT 'Database dropped' as STATUS;

-- ============================================================================
-- 5. DROP WAREHOUSE
-- ============================================================================
DROP WAREHOUSE IF EXISTS STRAVA_DEMO_WH;

SELECT 'Warehouse dropped' as STATUS;

-- ============================================================================
-- 6. DROP ROLE
-- ============================================================================
-- Note: This will fail if the role is currently in use by any user session
-- If it fails, disconnect any sessions using this role and retry
DROP ROLE IF EXISTS STRAVA_DEMO_ADMIN;

SELECT 'Role dropped' as STATUS;

-- ============================================================================
-- 7. VERIFY CLEANUP
-- ============================================================================
-- These queries should return no results if cleanup was successful

-- Check if database exists (should return empty)
SHOW DATABASES LIKE 'STRAVA_DEMO_SAMPLE';

-- Check if warehouse exists (should return empty)
SHOW WAREHOUSES LIKE 'STRAVA_DEMO_WH';

-- Check if role exists (should return empty)
SHOW ROLES LIKE 'STRAVA_DEMO_ADMIN';

SELECT '✅ Cleanup completed successfully! All demo resources have been removed.' as STATUS;

-- ============================================================================
-- Cleanup Complete!
-- All demo resources have been permanently deleted.
-- 
-- To run the demo again:
-- 1. Run 00_setup_environment.sql
-- 2. Run 01_strava_dynamic_tables_demo.ipynb
-- ============================================================================

