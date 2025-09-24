validate_data <- function(df) {
  required_cols <- c("id", "site", "date", "type", "value", "carbon_emission_kgco2e")
  all(required_cols %in% colnames(df))
}