chooseCRANmirror()


install.packages("xtable")
install.packages("shiny")
install.packages("readxl")
install.packages("dplyr")
install.packages("sass")
install.packages("memoise")
install.packages("stringr")

library(shiny)
library(readxl)
library(dplyr)
library(sass)
library(memoise)
library(stringr)

# Define UI
ui <- fluidPage(
  titlePanel("Multifamily Real Estate Model"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file1", "Upload Financial Statement", accept = c(".xlsx")),
      textInput("location", "Location"),
      numericInput("units", "Units", value = 0),
      numericInput("year_built", "Year Built", value = 0),
      dateInput("acquisition_date", "Acquisition Date"),
      numericInput("hold_period", "Hold Period", value = 0),
      numericInput("purchase_price", "Purchase Price", value = 0),
      numericInput("acquisition_closing_costs", "Acquisition Closing Costs", value = 0),
      numericInput("total_renovation_amount", "Total Renovation Amount", value = 0),
      numericInput("defensive_renovation_budget_contingency", "Defensive Renovation Budget Contingency (%)", value = 0),
      numericInput("offensive_renovation_budget_contingency", "Offensive Renovation Budget Contingency (%)", value = 0),
      numericInput("occupancy_year1", "Occupancy Year 1 (%)", value = 0),
      numericInput("occupancy_year2", "Occupancy Year 2 (%)", value = 0),
      numericInput("occupancy_year3", "Occupancy Year 3 (%)", value = 0),
      numericInput("occupancy_year4", "Occupancy Year 4 (%)", value = 0),
      numericInput("rent_growth_year1", "Rent Growth Year 1 (%)", value = 0),
      numericInput("rent_growth_year2", "Rent Growth Year 2 (%)", value = 0),
      numericInput("rent_growth_year3", "Rent Growth Year 3 (%)", value = 0),
      dateInput("capex_defensive_start_date", "Capital Expenditures Defensive Start Date (MM/DD/YYYY)"),
      numericInput("capex_defensive_duration", "Capital Expenditures Defensive Duration (Months)", value = 0),
      dateInput("capex_offensive_start_date", "Capital Expenditures Offensive Start Date (MM/DD/YYYY)"),
      numericInput("capex_offensive_duration", "Capital Expenditures Offensive Duration (Months)", value = 0),
      numericInput("unit_renovations_cost_per_unit", "Unit Renovations Cost/Unit", value = 0),
      numericInput("unit_renovation_rent_premium", "Unit Renovation Rent Premium", value = 0),
      numericInput("gp_equity", "GP Equity (%)", value = 0),
      numericInput("hurdle1_pref", "Hurdle #1 Pref (%)", value = 0),
      numericInput("hurdle2_promote", "Hurdle #2 Promote (%)", value = 0),
      numericInput("hurdle2_pref", "Hurdle #2 Pref (%)", value = 0),
      numericInput("hurdle3_promote", "Hurdle #3 Promote (%)", value = 0),
      numericInput("hurdle3_pref", "Hurdle #3 Pref (%)", value = 0),
      numericInput("hurdle4_promote", "Hurdle #4 Promote (%)", value = 0),
      numericInput("exit_cap_rate", "Exit Cap Rate (%)", value = 0),
      numericInput("exit_closing_costs", "Exit Closing Costs (%)", value = 0),
      radioButtons("financing_type", "Floating or Fixed Financing", choices = list("Floating" = "Floating", "Fixed" = "Fixed")),
      numericInput("loan_to_purchase_price", "Loan-to-Purchase Price (%)", value = 0),
      numericInput("interest_rate_spread", "Interest Rate Spread", value = 0),
      numericInput("fixed_rate", "Fixed Rate (%)", value = 0),
      numericInput("interest_only_period", "Interest Only Period (Months)", value = 0),
      numericInput("amortization_period_years", "Amortization Period (Years)", value = 0),
      numericInput("amortization_period_months", "Amortization Period (Months)", value = 0),
      numericInput("amortization_rate", "Amortization Rate (%)", value = 0),
      numericInput("origination_fee", "Origination Fee (%)", value = 0),
      numericInput("repairs_maintenance_per_unit", "Repairs and Maintenance Per Unit", value = 0),
      numericInput("turnover_per_unit", "Turnover Per Unit", value = 0),
      numericInput("marketing_per_unit", "Marketing Per Unit", value = 0),
      numericInput("general_admin_per_unit", "General & Administrative Per Unit", value = 0),
      numericInput("payroll_per_unit", "Payroll Per Unit", value = 0),
      numericInput("management_fees_per_unit", "Management Fees Per Unit (%)", value = 0),
      numericInput("utilities_per_unit", "Utilities Per Unit", value = 0),
      numericInput("total_real_estate_taxes", "Total Real Estate Taxes", value = 0),
      numericInput("property_insurance_per_unit", "Property Insurance Per Unit", value = 0),
      numericInput("capital_reserves_per_unit", "Capital Reserves Per Unit", value = 0),
      numericInput("other_revenue_growth_year1", "Other Revenue Growth Year 1 (%)", value = 0),
      numericInput("other_revenue_growth_year2", "Other Revenue Growth Year 2 (%)", value = 0),
      numericInput("other_revenue_growth_year3", "Other Revenue Growth Year 3 (%)", value = 0),
      numericInput("expense_growth_year1", "Expense Growth Year 1 (%)", value = 0),
      numericInput("expense_growth_year2", "Expense Growth Year 2 (%)", value = 0),
      numericInput("expense_growth_year3", "Expense Growth Year 3 (%)", value = 0),
      numericInput("ret_growth_year1", "RET Growth Year 1 (%)", value = 0),
      numericInput("ret_growth_year2", "RET Growth Year 2 (%)", value = 0),
      numericInput("ret_growth_year3", "RET Growth Year 3 (%)", value = 0),
      numericInput("num_studios", "Number of Studios", value = 0),
      numericInput("size_studios", "Size of Studios (SQFT)", value = 0),
      numericInput("num_1bed_1bath", "Number of 1 Bed, 1 Bath", value = 0),
      numericInput("size_1bed_1bath", "Size of 1 Bed, 1 Bath (SQFT)", value = 0),
      numericInput("num_2bed_2bath", "Number of 2 Bed, 2 Bath", value = 0),
      numericInput("size_2bed_2bath", "Size of 2 Bed, 2 Bath (SQFT)", value = 0),
      numericInput("num_3bed_2bath", "Number of 3 Bed, 2 Bath", value = 0),
      numericInput("size_3bed_2bath", "Size of 3 Bed, 2 Bath (SQFT)", value = 0)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Historical Financials", tableOutput("historical_financials")),
        tabPanel("Financials", tableOutput("contents")),
        tabPanel("Inputs & Drivers", 
                 h4("Defensive Renovation Budget"),
                 tableOutput("defensive_renovation_budget"),
                 h4("Offensive Renovation Budget"),
                 tableOutput("offensive_renovation_budget"),
                 h4("Joint Venture Assumptions"),
                 tableOutput("joint_venture_assumptions")
        )
      )
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  get_data <- reactive({
    file <- input$file1
    if (is.null(file)) {
      return(NULL)
    }
    df <- read_excel(file$datapath, sheet = "Historical Financials", skip = 5)
    return(df)
  })
  
  # Function to calculate historical financials
  calculate_historical_financials <- function(df) {
    # Define column mappings
    income_mapping <- list(
      "Net Effective Rent" = c("Gross Potential", "Loss To Lease", "Upfront Concessions"),
      "Vacancy Loss" = c("Loss To Vacancy"),
      "Non-Revenue Units" = c("Office Rent", "Model / Office Rent"),
      "Bad Debt" = c("Recovery of Bad Debt"),
      "Utility Reimbursement" = c("Pest Control Reimbursement", "Pest Control Reimb", "Rubs - Trash", "Rubs - Water"),
      "Other Revenue" = c("Late Fees", "Application Fees", "Month to Month Fees", "Short Term Lease Fee", "Utility Penalty Fee", 
                          "Deposit Forfeiture", "Admin Fee", "Non Refundable Pet Dep", "NSF Check Fees", "Parking & Storage Fees", 
                          "Cable", "Renters Insurance", "Pet Fees", "Damange Paid By Tenant", "Termination Fees", "Legal & Collection Rev", 
                          "Vacant Cost Recovery", "Cleaning Fees", "Miscellaneous Income", "Interest Income")
    )
    
    expenses_mapping <- list(
      "Repairs & Maintenance" = c("Total Repairs & Maintenance", "Total Grounds Maintenance"),
      "Turnover" = c("Total Apartment Turn Costs"),
      "Marketing" = c("Total Leasing Costs"),
      "General & Administrative" = c("Total General & Administrative", "Total Legal & Accounting"),
      "Payroll" = c("Total property payroll"),
      "Management Fees" = c("Total Management Fees"),
      "Utilities" = c("Total Utilities"),
      "Real Estate Taxes" = c("Real Estate Taxes"),
      "Property Insurance" = c("Property Insurance")
    )
    
    # Initialize result dataframe
    result <- data.frame(
      Month = df$Month,
      NetEffectiveRent = 0,
      VacancyLoss = 0,
      NonRevenueUnits = 0,
      BadDebt = 0,
      TotalRentalIncome = 0,
      UtilityReimbursement = 0,
      OtherRevenue = 0,
      TotalOtherRevenue = 0,
      TotalIncome = 0,
      RepairsMaintenance = 0,
      Turnover = 0,
      Marketing = 0,
      GeneralAdministrative = 0,
      Payroll = 0,
      ManagementFees = 0,
      Utilities = 0,
      RealEstateTaxes = 0,
      PropertyInsurance = 0,
      TotalOperatingExpenses = 0,
      NOI = 0
    )
    
    # Helper function to sum columns
    sum_columns <- function(df, columns) {
      col_indices <- which(str_to_lower(names(df)) %in% str_to_lower(columns))
      rowSums(df[, col_indices, drop = FALSE], na.rm = TRUE)
    }
    
    # Calculate income
    result$NetEffectiveRent <- sum_columns(df, income_mapping$NetEffectiveRent)
    result$VacancyLoss <- sum_columns(df, income_mapping$VacancyLoss)
    result$NonRevenueUnits <- sum_columns(df, income_mapping$NonRevenueUnits)
    result$BadDebt <- sum_columns(df, income_mapping$BadDebt)
    result$TotalRentalIncome <- result$NetEffectiveRent + result$VacancyLoss + result$NonRevenueUnits + result$BadDebt
    result$UtilityReimbursement <- sum_columns(df, income_mapping$UtilityReimbursement)
    result$OtherRevenue <- sum_columns(df, income_mapping$OtherRevenue)
    result$TotalOtherRevenue <- result$UtilityReimbursement + result$OtherRevenue
    result$TotalIncome <- result$TotalRentalIncome + result$TotalOtherRevenue
    
    # Calculate operating expenses
    result$RepairsMaintenance <- sum_columns(df, expenses_mapping$RepairsMaintenance)
    result$Turnover <- sum_columns(df, expenses_mapping$Turnover)
    result$Marketing <- sum_columns(df, expenses_mapping$Marketing)
    result$GeneralAdministrative <- sum_columns(df, expenses_mapping$GeneralAdministrative)
    result$Payroll <- sum_columns(df, expenses_mapping$Payroll)
    result$ManagementFees <- sum_columns(df, expenses_mapping$ManagementFees)
    result$Utilities <- sum_columns(df, expenses_mapping$Utilities)
    result$RealEstateTaxes <- sum_columns(df, expenses_mapping$RealEstateTaxes)
    result$PropertyInsurance <- sum_columns(df, expenses_mapping$PropertyInsurance)
    result$TotalOperatingExpenses <- rowSums(result[, c("RepairsMaintenance", "Turnover", "Marketing", "GeneralAdministrative", "Payroll", "ManagementFees", "Utilities", "RealEstateTaxes", "PropertyInsurance")])
    
    # Calculate NOI
    result$NOI <- result$TotalIncome - result$TotalOperatingExpenses
    
    return(result)
  }
  
  # Render the historical financials table
  output$historical_financials <- renderTable({
    df <- get_data()
    if (is.null(df)) {
      return(NULL)
    }
    historical_financials <- calculate_historical_financials(df)
    return(historical_financials)
  })
  
  # Function to calculate renovation budget
  calculate_renovation_budget <- function(total_renovation_amount, renovation_budget_contingency, units) {
    per_unit <- total_renovation_amount / units
    contingency_total <- total_renovation_amount * (renovation_budget_contingency / 100)
    contingency_per_unit <- contingency_total / units
    subtotal_total <- total_renovation_amount + contingency_total
    subtotal_per_unit <- per_unit + contingency_per_unit
    
    data.frame(
      "Per Unit" = c(per_unit, contingency_per_unit, subtotal_per_unit),
      "Total" = c(total_renovation_amount, contingency_total, subtotal_total),
      row.names = c("Amount", "Contingency", "Subtotal")
    )
  }
  
  output$defensive_renovation_budget <- renderTable({
    if (input$units > 0) {
      calculate_renovation_budget(input$total_renovation_amount, input$defensive_renovation_budget_contingency, input$units)
    }
  })
  
  output$offensive_renovation_budget <- renderTable({
    if (input$units > 0) {
      calculate_renovation_budget(input$total_renovation_amount, input$offensive_renovation_budget_contingency, input$units)
    }
  })
  
  # Function to calculate joint venture assumptions
  calculate_joint_venture_assumptions <- function(gp_equity, hurdle1_pref, hurdle2_promote, hurdle2_pref, hurdle3_promote, hurdle3_pref, hurdle4_promote) {
    splits_hurdle2 <- gp_equity + (hurdle2_promote * (1 - hurdle2_promote))
    splits_hurdle3 <- gp_equity + (hurdle3_promote * (1 - hurdle3_promote))
    splits_hurdle4 <- gp_equity + (hurdle4_promote * (1 - hurdle4_promote))
    
    data.frame(
      " " = c("Hurdle #1", "Hurdle #2", "Hurdle #3", "Hurdle #4"),
      "Promote" = c(NA, hurdle2_promote, hurdle3_promote, hurdle4_promote),
      "Pref" = c(hurdle1_pref, hurdle2_pref, hurdle3_pref, 500),
      "Splits" = c(gp_equity, splits_hurdle2, splits_hurdle3, splits_hurdle4),
      stringsAsFactors = FALSE
    )
  }
  
  # Render the joint venture assumptions table
  output$joint_venture_assumptions <- renderTable({
    calculate_joint_venture_assumptions(
      input$gp_equity,
      input$hurdle1_pref,
      input$hurdle2_promote,
      input$hurdle2_pref,
      input$hurdle3_promote,
      input$hurdle3_pref,
      input$hurdle4_promote
    )
  })
  
# Function to calculate financing assumptions
calculate_financing_assumptions <- function(units, repairs_maintenance_per_unit, turnover_per_unit, marketing_per_unit, general_administrative_per_unit, payroll_per_unit, management_fees_total, utilities_per_unit, total_real_estate_taxes, property_insurance_per_unit, capital_reserves_per_unit, total_rental_income, management_fees_per_unit_percent) {
  management_fees_per_unit <- management_fees_total / units
  real_estate_taxes_per_unit <- total_real_estate_taxes / units
  
  per_unit_row <- c(
    repairs_maintenance_per_unit,
    turnover_per_unit,
    marketing_per_unit,
    general_administrative_per_unit,
    payroll_per_unit,
    management_fees_per_unit,
    utilities_per_unit,
    real_estate_taxes_per_unit,
    property_insurance_per_unit
  )
  
  per_unit_subtotal <- sum(per_unit_row)
  per_unit_total <- per_unit_subtotal + capital_reserves_per_unit
  
  total_row <- c(
    repairs_maintenance_per_unit * units,
    turnover_per_unit * units,
    marketing_per_unit * units,
    general_administrative_per_unit * units,
    payroll_per_unit * units,
    total_rental_income * management_fees_per_unit_percent / 100,
    utilities_per_unit * units,
    total_real_estate_taxes,
    property_insurance_per_unit * units
  )
  
  total_subtotal <- sum(total_row)
  total_total <- total_subtotal + (capital_reserves_per_unit * units)
  
  data.frame(
    " " = c("Per Unit", "Total"),
    "Repairs & Maintenance" = c(repairs_maintenance_per_unit, repairs_maintenance_per_unit * units),
    "Turnover" = c(turnover_per_unit, turnover_per_unit * units),
    "Marketing" = c(marketing_per_unit, marketing_per_unit * units),
    "General & Administrative" = c(general_administrative_per_unit, general_administrative_per_unit * units),
    "Payroll" = c(payroll_per_unit, payroll_per_unit * units),
    "Management Fees" = c(management_fees_per_unit, total_rental_income * management_fees_per_unit_percent / 100),
    "Utilities" = c(utilities_per_unit, utilities_per_unit * units),
    "Real Estate Taxes" = c(real_estate_taxes_per_unit, total_real_estate_taxes),
    "Property Insurance" = c(property_insurance_per_unit, property_insurance_per_unit * units),
    "Subtotal" = c(per_unit_subtotal, total_subtotal),
    "Capital Reserves" = c(capital_reserves_per_unit, capital_reserves_per_unit * units),
    "Total" = c(per_unit_total, total_total),
    stringsAsFactors = FALSE
  )
}

# Render the financing assumptions table
output$financing_assumptions <- renderTable({
  calculate_financing_assumptions(
    input$units,
    input$repairs_maintenance_per_unit,
    input$turnover_per_unit,
    input$marketing_per_unit,
    input$general_admin_per_unit,
    input$payroll_per_unit,
    input$total_rental_income, # This should be the total rental income assumption or calculated value
    input$utilities_per_unit,
    input$total_real_estate_taxes,
    input$property_insurance_per_unit,
    input$capital_reserves_per_unit,
    input$total_rental_income, # Assuming total rental income is available here or from another input
    input$management_fees_per_unit_percent
  )
})

  
      
      