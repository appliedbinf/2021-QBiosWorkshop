# Ensure all the required libraries are installed
packages = c("shiny", "deSolve")
install.packages(setdiff(packages, rownames(installed.packages())))
library(shiny)
library(deSolve)

# "Source" or load the code used to run the SIR model
source("https://raw.githubusercontent.com/appliedbinf/GaTech-Weitz-ShieldImmunity/master/sir/pocmodel.R")

ui <- sidebarLayout(
  sidebarPanel(
    sliderInput(
      inputId = "alpha",
      label = HTML("&alpha;, Strength of shielding"),
      min = 0,
      max = 20,
      value = 2,
      step = .1
    ),
    sliderInput(
      inputId = "beta",
      label= HTML("&beta;, transmission rate/day"),
      min = 0.15,
      max = .3,
      value = .2,
      step=.005
    ),
    # radio buttons are another input type, choose 1 option from a list
    radioButtons(
      inputId = "model",
      label = "Choose the type of dynamic model to fit",
      choices = c(
        "Conventional" = "core", # Long descrptive name = short name
        "Flexible" = "soft",
        "Fixed" = "hard"
      ),
      selected = "core",
      inline = T # Show options on one line instead of a list with line breaks
    )
  ),
  
  mainPanel(fluidPage(
    fluidRow(plotOutput("p_model"))
  ))
)

server <- function(input, output, ...){
  pars = list()
  pars['gamma'] = 1 / 10
  y0 = c('S' = 0.999, 'I' = 0.001, 'R' = 0) # Supplied by JSW
  t = 0:200 # Day index, 0 to 200
  output$p_model <- renderPlot({
    pars['alpha'] = input$alpha
    pars['beta'] = input$beta
    pars['R0'] = pars$beta / pars$gamma
    par_model = input$model
    # Generate SIR from user input
    model_output = SIR_shield(t, y0, shield = par_model, pars)
    plot(x = seq(0, 200), y=model_output$I, type = "l",
         main= "Infections over time",
         xlab = "Days since outbreak",
         ylab = "Percent of population infected per day",
         ylim = c(0, 0.3))
    legend("topleft", 
           legend = paste0("R0 = ", pars['R0'])
    )
  })
}

shinyApp(ui, server)
