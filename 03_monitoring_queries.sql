-- ============================================================================
-- Strava Dynamic Tables Demo - Monitoring Queries
-- ============================================================================
-- Use these queries to monitor your Dynamic Tables and source data
-- ============================================================================

USE ROLE STRAVA_DEMO_ADMIN;
USE WAREHOUSE STRAVA_DEMO_WH;
USE DATABASE STRAVA_DEMO_SAMPLE;

-- ============================================================================
-- 1. CHECK DYNAMIC TABLE STATUS
-- ============================================================================
-- View all Dynamic Tables in the schema
SHOW DYNAMIC TABLES IN SCHEMA STRAVA_DYNAMIC_TABLES;

-- ============================================================================
-- 2. DYNAMIC TABLE REFRESH HISTORY
-- ============================================================================
-- Monitor refresh history for both Dynamic Tables
WITH refresh_history AS (
    SELECT 
        name,
        refresh_start_time,
        refresh_end_time,
        DATEDIFF('second', refresh_start_time, refresh_end_time) as duration_seconds,
        state,
        refresh_action,
        refresh_trigger,
        data_timestamp
    FROM TABLE(SNOWFLAKE.INFORMATION_SCHEMA.DYNAMIC_TABLE_REFRESH_HISTORY())
    WHERE name IN ('ACTIVITY_INTELLIGENCE', 'ATHLETE_PERFORMANCE_DASHBOARD')
),
table_stats AS (
    SELECT 
        'ACTIVITY_INTELLIGENCE' as name,
        COUNT(*) as total_rows
    FROM STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE
    UNION ALL
    SELECT 
        'ATHLETE_PERFORMANCE_DASHBOARD' as name,
        COUNT(*) as total_rows
    FROM STRAVA_DYNAMIC_TABLES.ATHLETE_PERFORMANCE_DASHBOARD
)
SELECT 
    rh.name,
    rh.refresh_start_time,
    rh.refresh_end_time,
    rh.duration_seconds,
    rh.state,
    rh.refresh_action,
    rh.refresh_trigger,
    rh.data_timestamp,
    ts.total_rows as current_total_rows
FROM refresh_history rh
LEFT JOIN table_stats ts ON rh.name = ts.name
ORDER BY rh.name, rh.refresh_start_time DESC;

-- ============================================================================
-- 3. SOURCE TABLE STATISTICS
-- ============================================================================
-- Check source ACTIVITIES table row count and latest data
SELECT 
    COUNT(*) as total_activities,
    COUNT(DISTINCT athlete_id) as unique_athletes,
    MIN(start_date_local) as earliest_activity,
    MAX(start_date_local) as latest_activity,
    COUNT(CASE WHEN start_date_local >= DATEADD('hour', -1, CURRENT_TIMESTAMP()) THEN 1 END) as activities_last_hour
FROM RAW_DATA.ACTIVITIES;

-- ============================================================================
-- 4. ACTIVITY INTELLIGENCE TABLE - SAMPLE DATA
-- ============================================================================
-- View AI-generated insights from the first Dynamic Table
SELECT 
    activity_id,
    athlete_id,
    activity_type,
    ROUND(distance_meters/1000.0, 2) as distance_km,
    ROUND(moving_time_sec/60.0, 1) as duration_min,
    ROUND(pace_kmh, 2) as pace_kmh,
    ai_performance_insight,
    processed_at
FROM STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE
ORDER BY processed_at DESC
LIMIT 10;

-- ============================================================================
-- 5. ATHLETE PERFORMANCE DASHBOARD - SAMPLE DATA
-- ============================================================================
-- View athlete aggregations and AI profiles from the second Dynamic Table
SELECT 
    athlete_id,
    total_activities_7d,
    ROUND(total_distance_km_7d, 1) as total_km_7d,
    ROUND(avg_distance_km, 1) as avg_km,
    ROUND(avg_pace_kmh, 1) as avg_pace_kmh,
    ROUND(avg_heartrate, 0) as avg_hr,
    performance_tier,
    ai_athlete_profile,
    last_activity_date,
    metrics_updated_at
FROM STRAVA_DYNAMIC_TABLES.ATHLETE_PERFORMANCE_DASHBOARD
ORDER BY total_distance_km_7d DESC
LIMIT 10;

-- ============================================================================
-- 6. PERFORMANCE TIER DISTRIBUTION
-- ============================================================================
-- See how athletes are distributed across performance tiers
SELECT 
    performance_tier,
    COUNT(*) as athlete_count,
    ROUND(AVG(total_distance_km_7d), 1) as avg_distance_km,
    ROUND(AVG(avg_pace_kmh), 1) as avg_pace,
    ROUND(AVG(total_activities_7d), 1) as avg_activities
FROM STRAVA_DYNAMIC_TABLES.ATHLETE_PERFORMANCE_DASHBOARD
GROUP BY performance_tier
ORDER BY avg_pace DESC;

-- ============================================================================
-- 7. ACTIVITY TYPE BREAKDOWN
-- ============================================================================
-- See distribution of activity types
SELECT 
    activity_type,
    COUNT(*) as count,
    ROUND(AVG(distance_meters/1000.0), 1) as avg_distance_km,
    ROUND(AVG(moving_time_sec/60.0), 1) as avg_duration_min,
    ROUND(AVG(pace_kmh), 1) as avg_pace_kmh,
    ROUND(AVG(average_heartrate), 0) as avg_heartrate
FROM STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE
GROUP BY activity_type
ORDER BY count DESC;

-- ============================================================================
-- 8. RECENT ACTIVITY TIMELINE
-- ============================================================================
-- Show activities processed in the last hour
SELECT 
    DATE_TRUNC('MINUTE', processed_at) as minute,
    COUNT(*) as activities_processed,
    COUNT(DISTINCT athlete_id) as unique_athletes
FROM STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE
WHERE processed_at >= DATEADD('hour', -1, CURRENT_TIMESTAMP())
GROUP BY DATE_TRUNC('MINUTE', processed_at)
ORDER BY minute DESC;

-- ============================================================================
-- 9. MODIFY DYNAMIC TABLE LAG (IF NEEDED)
-- ============================================================================
-- Uncomment and modify lag settings as needed:

-- Set more aggressive refresh (faster but more expensive)
-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE 
-- SET TARGET_LAG = '1 MINUTE';

-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ATHLETE_PERFORMANCE_DASHBOARD 
-- SET TARGET_LAG = '3 MINUTES';

-- Set less aggressive refresh (slower but cheaper)
-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE 
-- SET TARGET_LAG = '5 MINUTES';

-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ATHLETE_PERFORMANCE_DASHBOARD 
-- SET TARGET_LAG = '10 MINUTES';

-- ============================================================================
-- 10. SUSPEND/RESUME DYNAMIC TABLES (COST MANAGEMENT)
-- ============================================================================
-- Suspend Dynamic Tables when not in use to save costs:
-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE SUSPEND;
-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ATHLETE_PERFORMANCE_DASHBOARD SUSPEND;

-- Resume when ready to demo again:
-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ACTIVITY_INTELLIGENCE RESUME;
-- ALTER DYNAMIC TABLE STRAVA_DYNAMIC_TABLES.ATHLETE_PERFORMANCE_DASHBOARD RESUME;


