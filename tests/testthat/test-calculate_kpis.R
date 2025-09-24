test_that("KPI calculations are correct", {
  df <- data.frame(value = c(100, 200), carbon_emission_kgco2e = c(10, 20))
  logic <- SustainabilityData$new()
  kpis <- logic$calculate_kpis(df)
  expect_equal(kpis$total_consumption, 300)
  expect_equal(kpis$average_consumption, 150)
  expect_equal(kpis$total_emissions, 30)
})