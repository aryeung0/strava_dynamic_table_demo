# ⚡ Quick Start Guide - 3 Steps

## 1️⃣ Setup Environment (2 min)
```sql
-- Run this SQL script in Snowflake worksheet
00_setup_environment.sql
```
✅ Creates database, schemas, role, and warehouse

---

## 2️⃣ Run Complete Demo (15 min)
```
Open: 01_strava_dynamic_tables_demo.ipynb in Snowflake Notebooks
Run: All cells sequentially
```

### What This Notebook Does:

**Part 1: Data Streaming** (5 min)
- Creates ACTIVITIES table
- Generates and streams realistic activity data

**Part 2: Dynamic Tables** (5 min)
- Creates 2 AI-powered Dynamic Tables
- Sets up automated refresh pipeline

**Part 3: Monitoring** (3 min)
- View refresh history
- See AI-generated insights
- Analyze athlete profiles and metrics

**Part 4: Management** (2 min)
- Adjust LAG settings
- Suspend/Resume controls

✅ Complete end-to-end demo in one notebook!

---

## 3️⃣ Demo Real-Time Updates (5 min)
```
In same notebook:
Re-run: Part 1 streaming cell
Watch: Part 3 monitoring queries show auto-refresh!
```
✅ Observe Dynamic Tables processing new data automatically

---

## 📚 Additional Resources

- **README.md** - Complete documentation with architecture details
- **02_cleanup.sql** - Clean up all resources when done

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

## 🧹 Cleanup When Done

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
-- Removes all demo resources
```

Resume anytime with:
```sql
ALTER DYNAMIC TABLE ACTIVITY_INTELLIGENCE RESUME;
ALTER DYNAMIC TABLE ATHLETE_PERFORMANCE_DASHBOARD RESUME;
```

---

**Total Time: ~20 minutes | Difficulty: Easy | Wow Factor: High! 🚀**


