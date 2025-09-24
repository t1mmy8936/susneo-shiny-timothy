
SustainabilityData <- R6::R6Class(
  "SustainabilityData",
  public = list(
    #' @description Filter data by sites and date range.
    #' @param data Data frame.
    #' @param sites Vector of sites.
    #' @param date_range Vector of two dates (start, end).
    #' @return Filtered data frame.
    filter_data = function(data, sites, date_range) {
      dplyr::filter(data, site %in% sites, date >= date_range[1], date <= date_range[2])
    },
    
    #' @description Calculate KPIs from filtered data.
    #' @param filtered_data Filtered data frame.
    #' @return List of KPIs.
    calculate_kpis = function(filtered_data) {
      list(
        total_consumption = sum(filtered_data$value, na.rm = TRUE),
        average_consumption = mean(filtered_data$value, na.rm = TRUE),
        total_emissions = sum(filtered_data$carbon_emission_kgco2e, na.rm = TRUE)
      )
    }
  )
)