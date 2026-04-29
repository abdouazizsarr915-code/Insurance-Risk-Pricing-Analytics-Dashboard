# 📊 Insurance Risk & Pricing Analytics Dashboard

## 🔍 Full-Stack Analytics Project: From Raw Claims Data to Strategic Risk Decisions

---

## 🚀 Project Objective

This project investigates a structurally unprofitable insurance portfolio generating:

> **-$48.9M in total losses across Ohio, Illinois, and Indiana**

The goal was to:
- Identify **root drivers of financial leakage**
- Quantify **risk exposure across multiple dimensions**
- Deliver **data-driven underwriting & fraud strategies**

---

## 📂 Data Source

- **Dataset:** insurance_claims.csv  
- **Source:** Mendeley Data  
- **Contributor:** Abdelrahim Aqqad  
- Contains:
  - Policyholder demographics
  - Claim details
  - Incident types
  - Fraud indicator (`fraud_reported`)

---

# ⚙️ END-TO-END ANALYTICAL PIPELINE

## 1️⃣ Data Extraction (SQL)

Raw claims data was queried and structured using SQL:

- Extracted relevant features:
  - claim_amount
  - annual_premium
  - incident_type
  - age
  - policy_state
  - fraud_reported

- Built aggregated views:
  - Claims by state
  - Claims by age group
  - Claims by incident type

---

## 2️⃣ Data Cleaning & Feature Engineering (R)

Data preparation and transformation were performed in **R**.

### 🔹 Cleaning
- Removed inconsistencies
- Handled missing values
- Standardized categorical variables

### 🔹 Feature Engineering

```r
df$loss_ratio <- df$claim_amount / df$annual_premium
df$age_group <- cut(df$age, breaks = c(0,30,40,50,60,100))
