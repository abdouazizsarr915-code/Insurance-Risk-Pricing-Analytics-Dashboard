library(tidyverse)
library(janitor)
library(lubridate)

# 1. Load raw data
raw_data <- read.csv("data/raw/insurance_claims.csv")

# 2. Clean and prepare data
insurance <- raw_data %>%
  clean_names() %>%
  select(-x_c39) %>%
  mutate(across(where(is.character), ~na_if(.x, "?"))) %>%
  mutate(
    policy_bind_date = as.Date(policy_bind_date),
    incident_date = as.Date(incident_date)
  )

# 3. Create business variables
insurance_clean <- insurance %>%
  mutate(
    fraud_flag = ifelse(fraud_reported == "Y", 1, 0),
    has_claim = ifelse(total_claim_amount > 0, 1, 0),
    profit = policy_annual_premium - total_claim_amount,
    loss_ratio = total_claim_amount / policy_annual_premium,
    claim_severity = total_claim_amount,
    incident_month = floor_date(incident_date, "month"),
    
    age_group = case_when(
      age < 30 ~ "Under 30",
      age >= 30 & age < 40 ~ "30-39",
      age >= 40 & age < 50 ~ "40-49",
      age >= 50 & age < 60 ~ "50-59",
      age >= 60 ~ "60+",
      TRUE ~ "Unknown"
    ),
    
    vehicle_age = year(incident_date) - auto_year,
    
    vehicle_age_group = case_when(
      vehicle_age <= 5 ~ "0-5 years",
      vehicle_age <= 10 ~ "6-10 years",
      vehicle_age <= 15 ~ "11-15 years",
      vehicle_age > 15 ~ "15+ years",
      TRUE ~ "Unknown"
    )
  )

# 4. Export cleaned dataset
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

write.csv(
  insurance_clean,
  "data/processed/insurance_clean.csv",
  row.names = FALSE
)

# 5. Quick checks
glimpse(insurance_clean)
summary(insurance_clean$loss_ratio)
table(insurance_clean$fraud_reported)
sum(is.na(insurance_clean$police_report_available))