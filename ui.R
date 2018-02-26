library(shiny)
library(ggplot2)

# Define UI for application that draws a dose response curve
shinyUI(fluidPage(
      
      # Application title
      titlePanel("Dose Response Curve"),
      
      # Sidebar with a slider inputs
      sidebarLayout(
            sidebarPanel(
                  sliderInput(inputId = "c",
                              label = "Proportion of Drug B",
                              min = 0.5,
                              max = 1,
                              value = 0)
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                  plotOutput("slidePlot")
            )
      )
))
