# server.R
library(shiny)
library(DT)
library(lmtest)

server <- function(input, output) {
  
  # Render data table
  output$table <- renderDT({
    datatable(ecommerce)
  })
  
  output$scatter_plot <- renderPlot({
    plot(ecommerce[, input$x_var], ecommerce$y, 
         xlab = input$x_var, ylab = "y",
         main = paste("Scatter Plot of", input$x_var, "vs y"))
    
    # Add a red line to the scatter plot
    abline(lm(ecommerce$y ~ ecommerce[, input$x_var]), col = "red")
  })
  
  
  output$model_summary <- renderPrint({
    summary(model)
  })
  
  # Additional sections for model1
  model1 <- lm(y ~ x2 + x5, data = ecommerce)
  
  output$model1_summary <- renderPrint({
    summary(model1)
  })
  
  output$dw_test <- renderPrint({
    dwtest(model1)
  })
  
  output$bp_test <- renderPrint({
    bptest(model1, studentize = TRUE, data = ecommerce)
  })
  
  output$prediction_output <- renderText({
    if (input$predict_button > 0) {
      new_data <- data.frame(
        x1 = input$input_website_visitors,
        x2 = input$input_monthly_transactions,
        x3 = input$input_avg_items_per_transaction,
        x4 = input$input_customer_satisfaction,
        x5 = input$input_online_ads
      )
      prediction <- predict(model, newdata = new_data)
      paste("Predicted Sales:", scales::dollar(prediction))
    }
  })
  
  output$summary <- renderPrint({
    summary(ecommerce)
  })
  
  output$monthly_plot <- renderPlot({
    barplot(ecommerce$y, names.arg = ecommerce$Month, 
            col = "pink", ylim = c(0, max(ecommerce$y) + 50),
            xlab = "Month", ylab = "Sales (USD)",
            main = "Monthly Sales")
  })
}
