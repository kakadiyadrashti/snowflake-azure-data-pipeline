# Snowflake + Azure Blob Storage Data Pipeline (Starbucks Rewards)

## Overview
This project demonstrates an end-to-end data engineering and analytics pipeline using Azure Blob Storage and Snowflake. The dataset represents the Starbucks Customer Rewards Program, containing customer demographics, offer details, and transaction events.

The project covers the complete workflow from data ingestion to business insights, simulating a real-world data pipeline used in industry.

---

## Tech Stack
- Snowflake (Data Warehouse)
- Azure Blob Storage (Cloud Storage)
- SQL (Data Transformation & Analysis)
- JSON (Semi-structured Data)

---

## Dataset
The dataset consists of three JSON files:

- `profile.json` → Customer demographics (age, gender, income)
- `portfolio.json` → Offer details (reward, difficulty, duration, channels)
- `transcript.json` → Customer transactions and offer events

---

## ⚙️ Project Workflow

### 1. Data Ingestion
- Uploaded JSON files to Azure Blob Storage
- Created external stage in Snowflake
- Built external tables using VARIANT data type
- Validated ingestion using SELECT queries

**Data Volume:**
- 10 offers
- 17,000 customers
- 306,534 events

---

### 2. Data Cleaning & Transformation

- Replaced NULL gender values with 'O'
- Replaced NULL income values with 0
- Created `age_group` column for segmentation
- Converted channel array into separate boolean columns:
  - email, mobile, social, web
- Merged all datasets into a single table: `STARBUCKS_FULL`
- Removed informational offers (non-reward events)

**Final Dataset Size:** 280,468 records

---

### 3. Data Analysis

Key analyses performed:

- Top 5 customers by total spending
- Customer segmentation by age group
- Offer performance analysis
- Spending behavior analysis

**Key Insights:**
- Customers aged 50s and 60s generate the highest revenue
- 30s and 40s show strong engagement with offers
- Teenagers have lower spending but higher response to simple offers

---

### 4. Business Insights & Recommendations

**Best Offer Strategy:**
- 20s → Discount offers
- 30s & 40s → BOGO offers
- 50s → High-value discount offers
- Teenagers → Simple BOGO offers

**Campaign Cost Estimation:**
- 75% completion → $67,332
- 50% completion → $44,888
- 25% completion → $22,444

---

## Project Structure
snowflake-azure-data-pipeline/
│
├── data/ # Sample dataset (JSON / CSV)
├── sql/
│ ├── INGESTION.sql
│ ├── CLEANING.sql
│ ├── DATA_ANALYSIS.sql
│ ├── BUSINESSQUE.sql
│
├── results/
│ ├── EACH AGE GROUP.csv
│ ├── TOP 5 CLIENT.csv
│
├── report/
│ └── Assignment_Report.pdf
│
└── README.md
