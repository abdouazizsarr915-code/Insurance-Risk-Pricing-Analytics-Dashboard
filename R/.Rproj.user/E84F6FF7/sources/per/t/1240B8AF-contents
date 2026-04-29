library(tidyverse)
library(janitor)
library(lubridate)

# 1. Load enhanced dataset
insurance <- read.csv("data/processed/insurance_enhanced.csv") %>%
  clean_names() %>%
  mutate(
    incident_date = as.Date(incident_date),
    incident_month = floor_date(incident_date, "month")
  )

# 2. Create output folder
dir.create("outputs/tables_enhanced", recursive = TRUE, showWarnings = FALSE)

# 3. Overall KPIs
overall_kpis <- insurance %>%
  summarise(
    total_policies = n(),
    total_claims = sum(has_claim),
    claim_frequency = mean(has_claim),
    total_premium = sum(policy_annual_premium),
    total_claim_amount = sum(total_claim_amount),
    loss_ratio = total_claim_amount / total_premium,
    avg_claim_amount = sum(total_claim_amount, na.rm = TRUE) / sum(has_claim),
    total_profit = sum(profit),
    fraud_rate = mean(fraud_flag)
  )

# 4. Monthly trends
monthly_trends <- insurance %>%
  group_by(incident_month) %>%
  summarise(
    policies = n(),
    claims = sum(has_claim),
    claim_frequency = mean(has_claim),
    total_claim_amount = sum(total_claim_amount),
    loss_ratio = sum(total_claim_amount) / sum(policy_annual_premium),
    .groups = "drop"
  )

# 5. State risk
state_summary <- insurance %>%
  group_by(policy_state) %>%
  summarise(
    policies = n(),
    claims = sum(has_claim),
    claim_frequency = mean(has_claim),
    loss_ratio = sum(total_claim_amount) / sum(policy_annual_premium),
    fraud_rate = mean(fraud_flag),
    .groups = "drop"
  ) %>%
  arrange(desc(loss_ratio))

# 6. Age group risk
age_summary <- insurance %>%
  group_by(age_group) %>%
  summarise(
    policies = n(),
    claims = sum(has_claim),
    claim_frequency = mean(has_claim),
    loss_ratio = sum(total_claim_amount) / sum(policy_annual_premium),
    .groups = "drop"
  )

# 7. High-risk segments
high_risk <- insurance %>%
  group_by(policy_state, age_group, incident_type) %>%
  summarise(
    policies = n(),
    claims = sum(has_claim),
    claim_frequency = mean(has_claim),
    loss_ratio = sum(total_claim_amount) / sum(policy_annual_premium),
    fraud_rate = mean(fraud_flag),
    .groups = "drop"
  ) %>%
  filter(policies >= 20) %>%
  arrange(desc(loss_ratio))

# 8. Export
write.csv(overall_kpis, "outputs/tables_enhanced/overall_kpis.csv", row.names = FALSE)
write.csv(monthly_trends, "outputs/tables_enhanced/monthly_trends.csv", row.names = FALSE)
write.csv(state_summary, "outputs/tables_enhanced/state_summary.csv", row.names = FALSE)
write.csv(age_summary, "outputs/tables_enhanced/age_summary.csv", row.names = FALSE)
write.csv(high_risk, "outputs/tables_enhanced/high_risk.csv", row.names = FALSE)

# 9. Check
overall_kpis
head(high_risk)