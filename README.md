# 🏔️ Strava Dynamic Tables Demo 

A demonstration of Snowflake Dynamic Tables capabilities using Strava-like athletic activity data, enhanced with Cortex AI for intelligent insights.

## 📋 Table of Contents
- [Demo Overview](#demo-overview)
- [Quick Start (3 Steps)](#quick-start-3-steps)
- [Project Structure](#project-structure)
- [Architecture](#architecture)
- [Key Features](#key-features)
- [Expected Results](#expected-results)
- [Cleanup](#cleanup)

---

## 🎯 Demo Overview

This demo showcases how Dynamic Tables can automate data pipeline processing with built-in incremental refresh, combined with Snowflake Cortex AI to generate intelligent performance insights for athletes.

**Key Capabilities Demonstrated:**
- **Automated ETL Pipelines**: Declarative Dynamic Tables replace complex orchestration
- **Real-time Data Processing**: Near real-time activity metrics with configurable LAG
- **AI-Powered Insights**: Cortex COMPLETE generates personalized performance analysis
- **Self-Managing Infrastructure**: Built-in refresh scheduling and optimization

---

## ⚡ Quick Start

**Time: ~20 minutes | Difficulty: Easy**

### Prerequisites
- Snowflake account with ACCOUNTADMIN privileges
- Access to create Dynamic Tables
- Cortex AI functions enabled

### Step 1: Setup (2 min)
Run `00_setup_environment.sql` - Creates database, schemas, role, and warehouse

### Step 2: Run Demo (18 min)
Open `01_strava_dynamic_tables_demo.ipynb` in Snowflake Notebooks and run all cells:

1. **Stream Initial Data** - Generate baseline activities
2. **Create Dynamic Tables** - Build 2 AI-powered tables (1-min LAG)
3. **Stream More Data** - Watch tables auto-refresh every minute
4. **Monitor Results** - View refresh history and AI insights
5. **Manage Tables** - Adjust LAG or suspend/resume

### What You'll See
- **Activity Intelligence**: Real-time AI insights per activity (1-min refresh)
- **Athlete Dashboard**: Aggregated KPIs with AI profiles (1-min refresh)
- Live demonstration of incremental refresh as new data arrives

---

## 📁 Project Structure

**Files (Run in Order):**

1. **`00_setup_environment.sql`** - Initial setup (database, schema, role, warehouse)
2. **`01_strava_dynamic_tables_demo.ipynb`** - Complete end-to-end demo notebook
3. **`02_cleanup.sql`** - Remove all demo resources when done

## 🏗️ Architecture

### Data Flow
```
ACTIVITIES → ACTIVITY_INTELLIGENCE → ATHLETE_PERFORMANCE_DASHBOARD
(Source)     (1-min LAG, AI insights)  (2-min LAG, AI profiles)
```

### Dynamic Tables

**1. ACTIVITY_INTELLIGENCE** (1-min LAG)
- Processes each activity with AI-generated performance insights
- Calculates pace, duration, and other metrics
- Uses Cortex COMPLETE for personalized coaching feedback

**2. ATHLETE_PERFORMANCE_DASHBOARD** (1-min LAG)
- Aggregates athlete KPIs (distance, pace, heart rate)
- Classifies into performance tiers
- Generates AI athlete profiles and training recommendations

## 💡 Key Features

**AI Integration**
- Performance insights per activity using Cortex COMPLETE
- Athlete profiling with training recommendations
- No ML infrastructure needed

**Dynamic Tables Benefits**
- Declarative design - define what, not how
- Automatic refresh every minute
- Incremental processing - only changed data
- No orchestration required

**Optimizations**
- 1-minute LAG for near real-time insights
- 30-day rolling window for efficient processing
- Single warehouse architecture



## 📈 Sample Results

**Activity AI Insight:**
> "This Run shows strong endurance with 15.2 km/h pace over 10km. Consider interval training to improve speed."

**Athlete AI Profile:**
> "12 activities, 85.3 km total, 14.8 km/h avg pace, 152 bpm. Consistent training habits. Recommend 10% weekly distance increases."

**Performance Tiers:** High Performer (>15 km/h) | Regular Athlete (10-15) | Casual (<10)


---

## 🧹 Cleanup

When finished with the demo:

**Option 1: Suspend to Save Costs**
```sql
-- Use Part 4 of the notebook or run:
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE SUSPEND;
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD SUSPEND;
```

**Option 2: Complete Removal**
```sql
-- Run: 02_cleanup.sql
-- Removes all demo resources (database, schemas, tables, warehouse, role)
```

Resume anytime with:
```sql
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE RESUME;
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD RESUME;
```

---

## 📧 Support

For questions or issues with this demo, contact your Snowflake account team.

---

**Ready to build intelligent, self-managing data pipelines? 🚀**
