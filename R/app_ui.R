app_ui <- function(request) {
  fluidPage(
    # Theme or CSS if desired
    titlePanel("Sustainability Dashboard"),
    sidebarLayout(
      sidebarPanel(
        mod_data_upload_ui("data_upload_1")
      ),
      mainPanel(
        mod_dashboard_ui("dashboard_1")
      )
    )
  )
}