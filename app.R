# app.R - App runner
library(shiny)
library(golem)
library(ggplot2)
library(dplyr)
library(DT)

# Source all R files
source("R/utils.R")
source("R/SustainabilityData.R")
source("R/mod_data_upload.R")
source("R/mod_dashboard.R")
source("R/app_ui.R")
source("R/app_server.R")

run_app <- function(...) {
  with_golem_options(
    app = shinyApp(
      ui = app_ui,
      server = app_server
    ),
    golem_opts = list(...)
  )
}
run_app()
# Run with: run_app()
