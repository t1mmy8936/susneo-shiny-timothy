mod_data_upload_ui <- function(id) {
  ns <- NS(id)
  tagList(
    h4("Data Input"),
    fileInput(ns("file"), "Upload CSV File", accept = ".csv"),
    actionButton(ns("load_sample"), "Load Sample Data"),
    verbatimTextOutput(ns("status"))
  )
}

mod_data_upload_server <- function(id, r_data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    observeEvent(input$file, {
      tryCatch({
        # Read CSV
        df <- readr::read_csv(input$file$datapath, show_col_types = FALSE)
        
        # Rename if spaces in column
        if ("carbon emission in kgco2e" %in% colnames(df)) {
          df <- dplyr::rename(df, carbon_emission_kgco2e = `carbon emission in kgco2e`)
        }
        
        # Validate
        if (validate_data(df)) {
          # Parse dates
          df$date <- lubridate::dmy(df$date)
          r_data$data <- df
          output$status <- renderText("Data uploaded and validated successfully.")
        } else {
          output$status <- renderText("Invalid data: Missing required columns.")
        }
      }, error = function(e) {
        output$status <- renderText(paste("Error uploading data:", e$message))
      })
    })
    
    observeEvent(input$load_sample, {
      sample_path <- "data/sample_data.csv"
      if (file.exists(sample_path)) {
        df <- readr::read_csv(sample_path, show_col_types = FALSE)
        if ("carbon emission in kgco2e" %in% colnames(df)) {
          df <- dplyr::rename(df, carbon_emission_kgco2e = `carbon emission in kgco2e`)
        }
        df$date <- lubridate::dmy(df$date)
        r_data$data <- df
        output$status <- renderText("Sample data loaded successfully.")
      } else {
        output$status <- renderText("Sample data file not found.")
      }
    })
  })
}