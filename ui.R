# This is the user-interface definition of a Shiny web application. You can run the application using runApp().
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/

library(shiny)
library(ggplot2); library(dplyr)

mtcars2 <- mtcars %>%
    mutate(cyl = factor(cyl), am = factor(am), gear = factor(gear), vs = factor(vs), carb = factor(carb))

# Define UI for application that explore mtcars dataset

shinyUI(fluidPage(

    # Application title
    titlePanel("mtcars Explorer"),

    # Sidebar with input options
    sidebarLayout(
        # Sidebar with inputs
        sidebarPanel(
            # Select a variable from the select box for x variable.
            selectInput('var', label = 'X variable:',
                        choices = c("wt","hp","disp","qsec","drat")),
            # Select a variable from the radio buttons to use as color factor.
            radioButtons('color', 'Color:',
                         choices = c(names(mtcars2[sapply(mtcars2, is.factor)]))),
            # select a first number of rows to view the data
            numericInput("obs",
                         label = "Number of observations to view:", value = 5)
        ),
        # mainPanel for outputs
        mainPanel(
            h3("Scatter plot with linear regression fit"),
            plotOutput('plot'),

            h3("Observations"),
            tableOutput("view"),

            h3("str - data structure"),
            verbatimTextOutput('str')
        )
    )
))
