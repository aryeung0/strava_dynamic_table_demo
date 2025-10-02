# 🏔️ Strava Dynamic Tables Demo - Customer Version

A demonstration of Snowflake Dynamic Tables capabilities using Strava-like athletic activity data, enhanced with Cortex AI for intelligent insights.

## 🎯 Demo Overview

This demo showcases how Dynamic Tables can automate data pipeline processing with built-in incremental refresh, combined with Snowflake Cortex AI to generate intelligent performance insights for athletes.

**Key Capabilities Demonstrated:**
- **Automated ETL Pipelines**: Declarative Dynamic Tables replace complex orchestration
- **Real-time Data Processing**: Near real-time activity metrics with configurable LAG
- **AI-Powered Insights**: Cortex COMPLETE generates personalized performance analysis
- **Self-Managing Infrastructure**: Built-in refresh scheduling and optimization

## 📁 Project Structure

### Files (Run in Order)

1. **`00_setup_environment.sql`** - Initial setup (database, schema, role, warehouses)
2. **`01_data_streaming_simulator.ipynb`** - Create table and simulate streaming data
3. **`02_create_dynamic_tables.ipynb`** - Create Dynamic Tables with AI
4. **`03_monitoring_queries.sql`** - Monitor refresh activity and view results

## 🚀 Quick Start

### Prerequisites
1. Snowflake account with appropriate privileges (ACCOUNTADMIN to start)
2. Access to create Dynamic Tables
3. Cortex AI functions enabled (contact your Snowflake rep if needed)

### Step-by-Step Setup

#### Step 1: Run Environment Setup (One-Time)
Execute `00_setup_environment.sql` in a Snowflake worksheet:
- Creates database `STRAVA_DEMO_SAMPLE`
- Creates schemas `RAW_DATA` and `STRAVA_DYNAMIC_TABLES`
- Creates role `STRAVA_DEMO_ADMIN`
- Creates warehouses `STRAVA_DEMO_WH` and `STRAVA_DT_DEMO_WH`
- Sets up all necessary permissions

**Run this once per environment.**

#### Step 2: Generate and Stream Data
Open and execute `01_data_streaming_simulator.ipynb` in Snowflake Notebooks:
- Creates the `ACTIVITIES` table in `RAW_DATA` schema
- Generates realistic activity data (Run, Ride, Swim, Walk, Hike)
- Streams 10 activities every minute for 5 minutes (configurable)
- Provides sample queries to verify data

#### Step 3: Create Dynamic Tables
Open and execute `02_create_dynamic_tables.ipynb`:
- Creates `ACTIVITY_INTELLIGENCE` Dynamic Table (2-minute LAG)
  - Calculates pace metrics
  - Generates AI performance insights for each activity
- Creates `ATHLETE_PERFORMANCE_DASHBOARD` Dynamic Table (5-minute LAG)
  - Aggregates athlete KPIs
  - Classifies athletes into performance tiers
  - Generates AI athlete profiles and recommendations

#### Step 4: Monitor and Observe
Use `03_monitoring_queries.sql` to:
- View Dynamic Tables refresh history
- Check current row counts
- See AI-generated insights
- Monitor performance tier distribution
- Adjust LAG settings if needed

#### Step 5: Demo Real-Time Updates
1. Go back to `01_data_streaming_simulator.ipynb`
2. Run the streaming function again (Cell 12)
3. Watch as new activities are inserted
4. Use monitoring queries to see Dynamic Tables auto-refresh
5. Observe AI insights generated for new data

## 🏗️ Architecture

### Data Flow

```
RAW_DATA.ACTIVITIES (Source Table)
    ↓
    ↓ (2-minute LAG)
    ↓
ACTIVITY_INTELLIGENCE (Dynamic Table)
    - Calculate pace metrics
    - AI performance insights per activity
    ↓
    ↓ (5-minute LAG)
    ↓
ATHLETE_PERFORMANCE_DASHBOARD (Dynamic Table)
    - Aggregate athlete KPIs
    - Performance tier classification
    - AI athlete profiling
```

### Dynamic Tables Created

#### 1. **ACTIVITY_INTELLIGENCE** (2-minute LAG)
Real-time activity processing with AI-generated insights:
- **Source**: `RAW_DATA.ACTIVITIES` (last 30 days)
- **Features**:
  - Calculated pace metrics (km/h)
  - AI-powered performance insights using Cortex COMPLETE
  - Real-time activity processing timestamp
- **AI Enhancement**: LLM generates personalized performance analysis for each activity

#### 2. **ATHLETE_PERFORMANCE_DASHBOARD** (5-minute LAG)
Aggregated athlete KPIs with AI profiling:
- **Source**: `ACTIVITY_INTELLIGENCE`
- **Aggregations**:
  - Total activities and distance (7-day rolling)
  - Average pace and heart rate
  - Total elevation gain
  - Performance tier classification (High Performer, Regular Athlete, Casual User)
- **AI Enhancement**: LLM generates athlete profiles and training recommendations

## 💡 Key Features

### AI Integration with Cortex
- **Performance Insights**: LLM analyzes each activity (distance, pace, time) and provides coaching feedback
- **Athlete Profiling**: Generates personalized training recommendations based on aggregate metrics
- **Natural Language Output**: Human-readable insights for athletes and coaches
- **No ML Infrastructure**: Uses Snowflake's built-in `CORTEX.COMPLETE` function

### Dynamic Tables Benefits
- **Declarative Design**: Define what you want, not how to build it
- **Automatic Refresh**: Built-in scheduling with configurable LAG
- **Incremental Processing**: Efficient updates only for changed data
- **Dependency Management**: Automatic DAG creation and optimization
- **No Orchestration**: Replaces complex Airflow/dbt workflows

### Performance Optimization
- **Dedicated Warehouse**: Separate `STRAVA_DT_DEMO_WH` for Dynamic Tables workload
- **Configurable LAG**: 2-minute for activities, 5-minute for aggregations
- **Filtered Data**: Processes only recent activities (30-day window)
- **Smart Refresh**: Incremental updates minimize compute costs

## 📊 Demo Use Cases

### 1. Real-time Activity Processing
- **Challenge**: Process athlete activities as they upload
- **Solution**: 2-minute LAG Dynamic Table with AI insights
- **Outcome**: Near real-time performance feedback for athletes

### 2. Athlete Performance Analytics
- **Challenge**: Track athlete progress and engagement patterns
- **Solution**: Aggregated KPIs with performance tier classification
- **Outcome**: Segmented athlete groups for targeted engagement

### 3. AI-Powered Coaching
- **Challenge**: Provide personalized feedback at scale
- **Solution**: Cortex COMPLETE generates insights for each activity and athlete
- **Outcome**: Automated coaching recommendations without human review

## 🔧 Configuration Options

### Adjusting Refresh Frequency (LAG)

Modify LAG settings to balance freshness vs. cost:

```sql
-- More aggressive refresh (faster, higher cost)
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE SET TARGET_LAG = '1 MINUTE';
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD SET TARGET_LAG = '3 MINUTES';

-- Less aggressive refresh (slower, lower cost)
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE SET TARGET_LAG = '5 MINUTES';
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD SET TARGET_LAG = '10 MINUTES';
```

### Suspending to Save Costs

When not actively demoing, suspend to prevent ongoing refreshes:

```sql
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE SUSPEND;
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD SUSPEND;
ALTER WAREHOUSE STRAVA_DT_DEMO_WH SUSPEND;
```

Resume when ready:

```sql
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE RESUME;
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD RESUME;
```

## 📈 Expected Results

### Sample AI Insights

**Activity Performance Insight:**
> "This Run activity shows strong endurance performance with a 15.2 km/h pace over 10 kilometers. Consider incorporating interval training to improve speed while maintaining this excellent aerobic base."

**Athlete Profile:**
> "Based on 12 activities totaling 85.3 km with an average pace of 14.8 km/h and heart rate of 152 bpm, this athlete demonstrates consistent training habits. Recommend progressive overload with 10% weekly distance increases to continue fitness gains."

### Performance Tiers
- **High Performer**: Pace > 15 km/h (fast runners/cyclists)
- **Regular Athlete**: Pace 10-15 km/h (consistent training)
- **Casual User**: Pace < 10 km/h (recreational activities)

## 🎯 Business Value

### For Athletes
- Personalized AI coaching insights after every activity
- Performance tracking and tier classification
- Training recommendations based on historical patterns

### For Platform Teams
- Automated data pipelines without orchestration complexity
- Real-time insights without manual analysis
- Scalable AI-powered features without custom ML infrastructure

### For Business
- Engagement monitoring and intervention opportunities
- Performance-based user segmentation
- Premium feature demonstration (AI coaching)

## 🧹 Cleanup

To completely remove all demo objects:

```sql
USE ROLE ACCOUNTADMIN;

-- Drop objects
DROP SCHEMA IF EXISTS STRAVA_DEMO_SAMPLE.STRAVA_DYNAMIC_TABLES CASCADE;
DROP SCHEMA IF EXISTS STRAVA_DEMO_SAMPLE.RAW_DATA CASCADE;
DROP DATABASE IF EXISTS STRAVA_DEMO_SAMPLE CASCADE;
DROP WAREHOUSE IF EXISTS STRAVA_DT_DEMO_WH;
DROP WAREHOUSE IF EXISTS STRAVA_DEMO_WH;
DROP ROLE IF EXISTS STRAVA_DEMO_ADMIN;
```

## 🎬 Demo Tips

1. **Pre-load data**: Run the streaming simulator before the demo to have baseline data
2. **Show the DAG**: Explain how Dynamic Tables automatically manage dependencies
3. **Highlight AI**: Show actual AI-generated insights and how they vary per athlete
4. **Live refresh**: Stream new data and watch tables refresh in real-time
5. **Cost efficiency**: Discuss how LAG settings impact cost vs. freshness
6. **Compare to alternatives**: Mention how this replaces complex Airflow/dbt setups

## 📧 Support

For questions or issues with this demo, contact your Snowflake account team.

---

**Ready to build intelligent, self-managing data pipelines? 🚀**


