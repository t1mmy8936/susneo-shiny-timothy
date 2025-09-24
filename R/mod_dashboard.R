mod_dashboard_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h4("Filters"),
    dateRangeInput(ns("date_range"), "Date Range", start = "2025-07-31", end = "2025-09-11"),
    selectInput(ns("sites"), "Facilities (Multi-Select)", choices = NULL, multiple = TRUE, selected = c("VDRK", "AKBB", "GFBN", "GECE")),
    h4("Key Metrics"),
    fluidRow(
      column(4, verbatimTextOutput(ns("kpi1")), title = "Total Consumption"),
      column(4, verbatimTextOutput(ns("kpi2")), title = "Average Consumption"),
      column(4, verbatimTextOutput(ns("kpi3")), title = "Total Emissions")
    ),
    h4("Visualizations"),
    plotOutput(ns("time_series")),
    plotOutput(ns("comparison")),
    h4("Data Table"),
    DT::dataTableOutput(ns("table"))
  )
}

mod_dashboard_server <- function(id, r_data) {
  moduleServer(id, function(input, output, session) {
    # Instantiate R6 business logic
    business_logic <- SustainabilityData$new()
    
    # Update filter choices dynamically
    observe({
      if (!is.null(r_data$data)) {
        updateSelectInput(session, "sites", choices = unique(r_data$data$site), selected = unique(r_data$data$site))
        updateDateRangeInput(session, "date_range", start = min(r_data$data$date, na.rm = TRUE), end = max(r_data$data$date, na.rm = TRUE))
      }
    })
    
    # Filtered data (reactive)
    filtered_data <- reactive({
      req(r_data$data)
      business_logic$filter_data(r_data$data, input$sites, input$date_range)
    })
    
    # KPIs (reactive)
    kpis <- reactive({
      req(filtered_data())
      if (nrow(filtered_data()) == 0) return(list(total_consumption = 0, average_consumption = 0, total_emissions = 0))
      business_logic$calculate_kpis(filtered_data())
    })
    
    output$kpi1 <- renderText(kpis()$total_consumption)
    output$kpi2 <- renderText(round(kpis()$average_consumption, 2))
    output$kpi3 <- renderText(kpis()$total_emissions)
    
    # Time series chart
    output$time_series <- renderPlot({
      req(filtered_data())
      if (nrow(filtered_data()) == 0) return(ggplot() + labs(title = "No data"))
      filtered_data() %>%
        dplyr::group_by(date) %>%
        dplyr::summarise(total_value = sum(value, na.rm = TRUE)) %>%
        ggplot2::ggplot(aes(x = date, y = total_value)) +
        geom_line() +
        labs(title = "Energy Consumption Over Time", x = "Date", y = "Total Consumption")
    })
    
    # Comparison chart
    output$comparison <- renderPlot({
      req(filtered_data())
      if (nrow(filtered_data()) == 0) return(ggplot() + labs(title = "No data"))
      filtered_data() %>%
        dplyr::group_by(site) %>%
        dplyr::summarise(total_value = sum(value, na.rm = TRUE)) %>%
        ggplot2::ggplot(aes(x = site, y = total_value, fill = site)) +
        geom_bar(stat = "identity") +
        labs(title = "Consumption by Facility", x = "Facility", y = "Total Consumption")
    })
    
    # Data table
    output$table <- DT::renderDataTable({
      req(filtered_data())
      filtered_data()
    }, options = list(pageLength = 10))
  })
}