# ⚡ Quick Start Guide - 5 Steps

## 1️⃣ Setup Environment (2 min)
```sql
-- Run this SQL script in Snowflake worksheet
00_setup_environment.sql
```
✅ Creates database, schemas, role, and warehouses

---

## 2️⃣ Generate Data (7 min)
```
Open: 01_data_streaming_simulator.ipynb in Snowflake Notebooks
Run: All cells (creates table, generates, and streams activity data)
```
✅ Creates ACTIVITIES table with realistic data

---

## 3️⃣ Create Dynamic Tables (5 min)
```
Open: 02_create_dynamic_tables.ipynb
Run: All cells (creates AI-powered Dynamic Tables)
```
✅ Creates 2 Dynamic Tables with Cortex AI integration

---

## 4️⃣ Monitor Results (2 min)
```sql
-- Run these queries in Snowflake worksheet
03_monitoring_queries.sql

-- Key queries:
-- #2: Refresh history
-- #4: AI activity insights
-- #5: AI athlete profiles
```
✅ View refresh history and AI-generated insights

---

## 5️⃣ See Real-Time Updates (5 min)
```
Go back to: 01_data_streaming_simulator.ipynb
Re-run: Cell 12 (stream more data)
Watch: Dynamic Tables auto-refresh!
```
✅ Observe automatic incremental processing

---

## 📚 Additional Resources

- **README.md** - Complete documentation
- **DEMO_GUIDE.md** - Detailed demo walkthrough with talking points

---

## 🎯 What You'll See

### Activity Intelligence (Dynamic Table 1)
- Real-time activity processing (2-minute LAG)
- AI-generated performance insights per activity
- Example: *"This Run shows strong endurance with 15.2 km/h pace..."*

### Athlete Performance Dashboard (Dynamic Table 2)
- Aggregated athlete KPIs (5-minute LAG)
- Performance tier classification
- AI-generated athlete profiles
- Example: *"Based on 12 activities totaling 85.3 km, recommend progressive overload..."*

---

## ⏸️ Don't Forget to Suspend!

When done demoing, save costs by suspending:

```sql
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE SUSPEND;
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD SUSPEND;
ALTER WAREHOUSE STRAVA_DT_DEMO_WH SUSPEND;
```

Resume anytime with:
```sql
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE RESUME;
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD RESUME;
```

---

**Total Time: ~20 minutes | Difficulty: Easy | Wow Factor: High! 🚀**


