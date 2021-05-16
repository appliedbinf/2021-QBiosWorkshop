library(shiny)

# Required UI object for the Frontend.
ui <- fluidPage(
    h1("Hello Plots"),
    sliderInput(
        inputId = "alpha",
        label = "Strength of shielding",
        value = 1,
        min = .1,
        max = 10,
        step = 0.1
    ),
    plotOutput("simulation") # Display a plot here
)

# Required server function for the backend
server <- function(input, output){
  output$simulation <- renderPlot({
    x = seq(-10, 10, 1) # Generates the sequence -10, -9, -8, ..., 8, 9, 10
    y = dnorm(x, mean = 0, sd = input$alpha) # Generates a normal density distribution
                                             # with x, mean of 0 and standard dev = 5
    plot(x, y, type = "l") # Plot x and y as a line plot (type=“l”)
  })
}

# Shiny application instance consisting of a front and backend
shinyApp(ui, server)
