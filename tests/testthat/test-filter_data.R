test_that("Filter helper function works", {
  df <- data.frame(site = c("A", "B"), date = lubridate::dmy(c("01-01-2025", "01-02-2025")), value = 1:2)
  logic <- SustainabilityData$new()
  filtered <- logic$filter_data(df, sites = "A", date_range = c(lubridate::dmy("01-01-2025"), lubridate::dmy("31-01-2025")))
  expect_equal(nrow(filtered), 1)
  expect_equal(filtered$site, "A")
})