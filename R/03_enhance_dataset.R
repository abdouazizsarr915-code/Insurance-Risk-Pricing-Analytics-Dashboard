library(tidyverse)

# 1. Load cleaned data
insurance_clean <- read.csv("data/processed/insurance_clean.csv")

# 2. Create synthetic non-claim policies
set.seed(123)

no_claims <- insurance_clean %>%
  sample_n(2000, replace = TRUE) %>%   # create more policies
  mutate(
    total_claim_amount = 0,
    has_claim = 0,
    claim_severity = 0,
    loss_ratio = 0,
    profit = policy_annual_premium,
    fraud_flag = 0,
    fraud_reported = "N"
  )

# 3. Combine datasets
insurance_enhanced <- bind_rows(insurance_clean, no_claims)

# 4. Export enhanced dataset
dir.create("data/processed", recursive = TRUE, showWarnings = FALSE)

write.csv(
  insurance_enhanced,
  "data/processed/insurance_enhanced.csv",
  row.names = FALSE
)

# 5. Quick check
summary(insurance_enhanced$loss_ratio)
table(insurance_enhanced$has_claim)