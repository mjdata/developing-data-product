# shiny server
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(shiny)
library(ggplot2); library(dplyr)

mtcars2 <- mtcars %>%
    mutate(cyl = factor(cyl), am = factor(am), gear = factor(gear), vs = factor(vs), carb = factor(carb))

# Define server logic required to plot, view and show data structure of mtcars

shinyServer(function(input, output){

    # Make scatterplot with linear regression fit (Thick black line), for user chosen x variable and color
    #
    output$plot <- renderPlot({
        ggplot(mtcars2,aes_string(y = "mpg", x = input$var, col = input$color)) +
            geom_point(size = 1.5) +
            geom_smooth(method = lm, se = TRUE, color = "black")
    })

    # Show the first user chosen number (obs) of observations

    output$view <- renderTable({head(mtcars, n = input$obs)})

    # Print structure of the dataset
    output$str <- renderPrint({
        str(mtcars)
    })
})
