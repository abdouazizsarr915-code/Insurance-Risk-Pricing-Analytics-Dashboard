# 📊 Insurance Risk & Pricing Analytics Dashboard

## Unprofitable Portfolio Analysis: -$48.9M Loss Drivers Across IL, IN, OH

[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)]()
[![R](https://img.shields.io/badge/R-Analysis-276DC3?style=for-the-badge&logo=r&logoColor=white)]()
[![SQL](https://img.shields.io/badge/SQL-Data%20Engineering-4479A1?style=for-the-badge&logo=postgresql&logoColor=white)]()

---

## 📌 Executive Summary

**Business Problem:**  
A regional insurance portfolio is generating **-$48.9M in losses** across Ohio, Illinois, and Indiana.

**Objective:**  
Identify root causes of unprofitability and deliver actionable strategies.

**Key Result:**  
- **98% of losses originate from collision claims**
- **60+ drivers exhibit the highest fraud rate (13.4%)**
- Identified a clear **high-risk intersection (Age × Geography × Incident Type)**

---

## 📂 Data Source

Dataset: **insurance_claims.csv**  
Source: Mendeley Data  
Contributor: Abdelrahim Aqqad  

Each row represents an insurance claim with:
- Demographics (age, tenure)
- Incident type
- Claim severity
- Fraud indicator (`fraud_reported`)

---

## 📊 Key Insights

### 1. Regional Financial Impact

| State | Total Loss |
|------|-----------|
| Ohio (OH) | **-$17.1M** |
| Illinois (IL) | **-$16.5M** |
| Indiana (IN) | **-$15.3M** |

> All regions are structurally unprofitable.

---

### 2. Loss Concentration

| Incident Type | Loss | Share |
|---------------|------|--------|
| Single Vehicle Collision | $26M | 49% |
| Multi-Vehicle Collision | $26M | 49% |
| Other (Theft + Parked) | $1M | 2% |

> **Collision claims account for ~98% of total losses**

---

### 3. Fraud Risk by Age

| Age Group | Fraud Rate |
|-----------|------------|
| 60+ | **13.43%** |
| Under 30 | 9.03% |
| Others | 7.6% – 8.8% |

> The highest-frequency claim group is also the highest fraud risk.

---

### 4. High-Risk Intersection (Critical Finding)

The most severe financial leakage occurs when:

- **State:** Ohio or Indiana  
- **Incident Type:** Collision  
- **Age Group:** 60+  

👉 This segment combines **high severity + high fraud probability**

---

## 🛠️ Technical Process

**Pipeline:**
