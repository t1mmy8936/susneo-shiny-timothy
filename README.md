# susneo-shiny-timothy

[![R-CMD-check](https://github.com/yourusername/susneo-shiny-timothy/workflows/R-CMD-check/badge.svg)](https://github.com/yourusername/susneo-shiny-{yourname}/actions)

## Setup Instructions
1. Clone the repository: `git clone https://github.com/yourusername/susneo-shiny-{yourname}.git`
2. Install dependencies: `Rscript -e "install.packages('devtools'); devtools::install_deps()"`
3. Run the app: `shiny::runApp()` or source `app.R`.

## App Overview
This is a production-ready Shiny dashboard built with golem for visualizing company energy consumption and carbon emissions across facilities. It supports CSV upload or sample data, filters, KPIs, charts, and a data table.

(Add screenshot of running app here, e.g., via `![Screenshot](screenshot.png)` after capturing one locally.)

## Architecture
- **Modules**: 
  - `mod_data_upload`: Handles CSV upload, validation, and sample loading with error messages.
  - `mod_dashboard`: Manages filters, reactive KPIs, visualizations (using ggplot2), and interactive table (using DT).
- **R6 Class**: `SustainabilityData` encapsulates business logic for data filtering (by site/date) and KPI calculations (total/average consumption, total emissions). This promotes modularity and testability.

## Data
The dataset analyzes energy usage:
- **id**: Unique identifier (integer).
- **site**: Facility code (string, e.g., VDRK, AKBB).
- **date**: Date of usage (DD-MM-YYYY, parsed to Date).
- **type**: Energy type (string, e.g., Water, Electricity).
- **value**: Usage amount (numeric).
- **carbon_emission_kgco2e**: Emissions in kgCO2e (numeric).

Sample data is in `data/sample_data.csv` (~3000 rows).

## Testing
Run tests locally: `testthat::test_dir("tests/testthat")` or `devtools::test()`.

Tests cover data validation, KPI calculations, and filtering helper.