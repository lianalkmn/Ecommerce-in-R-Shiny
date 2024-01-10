# ui.R
library(shiny)

ui <- navbarPage(
  title = "Dashboard E-Commerce by Lia",
  id = "navbar",
  
  # CSS style for menu bar
  tags$head(
    tags$style(HTML("
      .navbar-default {
        background-color: #ff69b4;  /* Replace with desired pink color */
        border-color: #d6408c;  /* Replace with desired border color */
      }
      .navbar-default .navbar-brand {
        color: #ffffff;  /* Replace with contrasting text color */
      }
      .navbar-default .navbar-nav > li > a {
        color: #ffffff;  /* Replace with contrasting text color */
      }
    "))
  ),
  
  tabPanel("Home", 
           fluidPage(
             titlePanel("Dashboard E-Commerce by Lia"),
             h3("Welcome to the home page!"),
             h4("This dashboard is used to analyze factors influencing monthly sales volume 
                for an e-commerce company operating in Southeast Asian countries."),
             p("Please select one of the menus above to view other content.")
           )),
  
  tabPanel("Data", 
           fluidPage(
             titlePanel("Data & E-Commerce Data Summary"),
             HTML("<p><strong>Description:</strong></p>
                  <p><strong>y:</strong> Monthly sales volume (in thousands of USD)</p>
                  <p><strong>x1:</strong> Number of website visitors per month</p>
                  <p><strong>x2:</strong> Number of monthly transactions</p>
                  <p><strong>x3:</strong> Average number of items per transaction</p>
                  <p><strong>x4:</strong> Customer satisfaction rating (scale 1-10)</p>
                  <p><strong>x5:</strong> Number of online advertisements run per month"),
             dataTableOutput("table"),
             HTML("<p><strong>Data Summary:</strong></p>"),
             verbatimTextOutput("summary")
           )),
  
  tabPanel("Monthly Sales", 
           fluidPage(
             titlePanel("Monthly Sales"),
             mainPanel(
               plotOutput("monthly_plot")
             )
           )),
  
  tabPanel("Scatter Plot", 
           fluidPage(
             titlePanel("Scatter Plot of E-Commerce Data"),
             sidebarLayout(
               sidebarPanel(
                 selectInput("x_var", "Select X Variable:", names(ecommerce)[-c(1, length(names(ecommerce)))])
               ),
               mainPanel(
                 plotOutput("scatter_plot")
               )
             )
           )),
  
  tabPanel("Regression Model", 
           fluidPage(
             titlePanel("Regression Model Summary"),
             verbatimTextOutput("model_summary"),
             
             # Added sections for model1
             verbatimTextOutput("model1_summary"),
             titlePanel("Tests for Assumptions"),
             verbatimTextOutput("dw_test"),
             verbatimTextOutput("bp_test")
           )),
  
  tabPanel("Sales Prediction", 
           fluidPage(
             titlePanel("Sales Prediction"),
             sidebarLayout(
               sidebarPanel(
                 numericInput("input_website_visitors", "Enter Website Visitors:", value = 200000),
                 numericInput("input_monthly_transactions", "Enter Monthly Transactions:", value = 12000),
                 numericInput("input_avg_items_per_transaction", "Enter Average Items per Transaction:", value = 5.0),
                 numericInput("input_customer_satisfaction", "Enter Customer Satisfaction (scale 1-10):", value = 8.5),
                 numericInput("input_online_ads", "Enter Number of Online Ads:", value = 25000),
                 actionButton("predict_button", "Predict")
               ),
               mainPanel(
                 verbatimTextOutput("prediction_output")
               )
             )
           )))
