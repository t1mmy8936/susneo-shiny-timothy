app_server <- function(input, output, session) {
  # Shared reactive data
  r_data <- reactiveValues(data = NULL)
  
  # Modules
  mod_data_upload_server("data_upload_1", r_data = r_data)
  mod_dashboard_server("dashboard_1", r_data = r_data)
}