library(tidyverse)
library(lubridate)
library(janitor)

# 1. Load cleaned data
insurance_clean <- read.csv("data/processed/insurance_clean.csv") %>%
  clean_names() %>%
  mutate(
    incident_date = as.Date(incident_date),
    incident_month = as.Date(incident_month)
  )

# 2. Create output folder
dir.create("outputs/tables", recursive = TRUE, showWarnings = FALSE)

# 3. Overall KPIs
overall_kpis <- insurance_clean %>%
  summarise(
    total_claim_cases = n(),
    total_premium = sum(policy_annual_premium, na.rm = TRUE),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_premium = mean(policy_annual_premium, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    total_profit = sum(profit, na.rm = TRUE),
    fraud_cases = sum(fraud_flag, na.rm = TRUE),
    fraud_rate = mean(fraud_flag, na.rm = TRUE)
  )

# 4. Monthly trends
monthly_trends <- insurance_clean %>%
  group_by(incident_month) %>%
  summarise(
    claim_cases = n(),
    total_premium = sum(policy_annual_premium, na.rm = TRUE),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    fraud_rate = mean(fraud_flag, na.rm = TRUE),
    .groups = "drop"
  )

# 5. Risk by state
state_summary <- insurance_clean %>%
  group_by(policy_state) %>%
  summarise(
    claim_cases = n(),
    total_premium = sum(policy_annual_premium, na.rm = TRUE),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    fraud_rate = mean(fraud_flag, na.rm = TRUE),
    total_profit = sum(profit, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(average_loss_ratio))

# 6. Risk by incident type
incident_type_summary <- insurance_clean %>%
  group_by(incident_type) %>%
  summarise(
    claim_cases = n(),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    fraud_rate = mean(fraud_flag, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(average_loss_ratio))

# 7. Risk by age group
age_group_summary <- insurance_clean %>%
  group_by(age_group) %>%
  summarise(
    claim_cases = n(),
    total_premium = sum(policy_annual_premium, na.rm = TRUE),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    fraud_rate = mean(fraud_flag, na.rm = TRUE),
    total_profit = sum(profit, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(average_loss_ratio))

# 8. Risk by vehicle age
vehicle_age_summary <- insurance_clean %>%
  group_by(vehicle_age_group) %>%
  summarise(
    claim_cases = n(),
    total_premium = sum(policy_annual_premium, na.rm = TRUE),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    fraud_rate = mean(fraud_flag, na.rm = TRUE),
    total_profit = sum(profit, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(desc(average_loss_ratio))

# 9. Fraud analysis
fraud_summary <- insurance_clean %>%
  group_by(fraud_reported) %>%
  summarise(
    claim_cases = n(),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    average_vehicle_claim = mean(vehicle_claim, na.rm = TRUE),
    average_property_claim = mean(property_claim, na.rm = TRUE),
    average_injury_claim = mean(injury_claim, na.rm = TRUE),
    .groups = "drop"
  )

# 10. High-risk segments
high_risk_segments <- insurance_clean %>%
  group_by(policy_state, age_group, incident_type) %>%
  summarise(
    claim_cases = n(),
    total_claim_amount = sum(total_claim_amount, na.rm = TRUE),
    average_claim_amount = mean(total_claim_amount, na.rm = TRUE),
    average_loss_ratio = mean(loss_ratio, na.rm = TRUE),
    fraud_rate = mean(fraud_flag, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  filter(claim_cases >= 10) %>%
  arrange(desc(average_loss_ratio))

# 11. Export tables
write.csv(overall_kpis, "outputs/tables/overall_kpis.csv", row.names = FALSE)
write.csv(monthly_trends, "outputs/tables/monthly_trends.csv", row.names = FALSE)
write.csv(state_summary, "outputs/tables/state_summary.csv", row.names = FALSE)
write.csv(incident_type_summary, "outputs/tables/incident_type_summary.csv", row.names = FALSE)
write.csv(age_group_summary, "outputs/tables/age_group_summary.csv", row.names = FALSE)
write.csv(vehicle_age_summary, "outputs/tables/vehicle_age_summary.csv", row.names = FALSE)
write.csv(fraud_summary, "outputs/tables/fraud_summary.csv", row.names = FALSE)
write.csv(high_risk_segments, "outputs/tables/high_risk_segments.csv", row.names = FALSE)

# 12. Quick checks
overall_kpis
head(state_summary)
head(high_risk_segments)