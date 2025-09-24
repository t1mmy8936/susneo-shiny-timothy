test_that("Data validation checks columns", {
  good_df <- data.frame(id = 1, site = "A", date = "01-01-2025", type = "Gas", value = 100, carbon_emission_kgco2e = 10)
  expect_true(validate_data(good_df))
  
  bad_df <- data.frame(id = 1, site = "A")
  expect_false(validate_data(bad_df))
})