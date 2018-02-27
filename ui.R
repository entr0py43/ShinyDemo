library(shiny)
library(ggplot2)
library(plotly)

# Define UI for application that draws a dose response curve
shinyUI(fluidPage(
      
      # Application title
      titlePanel("Dose Response Curve"),
      
      # Sidebar with a slider inputs
      sidebarLayout(
            sidebarPanel(
                  sliderInput(inputId = "c",
                              label = "Proportion of Drug A in Combination",
                              min = 0.5,
                              max = 1,
                              value = 0.005)
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
                  plotlyOutput("slidePlot",
                               width = 600,
                               height = 500)
            )
      ),
      
      titlePanel("Drug B - Reference"),
      
      sidebarLayout(
            sidebarPanel(
                  textInput("drugB", "name of drugB", "Urotensin II"),
                  numericInput("Eb", "Emax-drugB", 72.44, min=1, max=200),
                  numericInput("Cb", "EC50-drugB (nM)", 6.52, min=0.01, max=1000)
            ),
            sidebarPanel(
                  textInput("drugA", "name of drugA", "Angiotensin II"),
                  numericInput("Ea", "Emax-drugA", 43.98, min=1, max=200),
                  numericInput("Ca", "EC50-drugA (nM)", 32.09, min=0.01, max=1000)
            )
      )
))
