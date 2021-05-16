library(shiny)

ui <- fluidPage(
  h1("Hello Plots"),
  plotOutput("plot")
)

server <- function(input, output) {
  output$plot <- renderPlot({
    x = seq(-10, 10, 1)
    y = dnorm(x, mean = 0, sd = 5)
    plot(x, y, type = "l")
  })
}

shinyApp(ui, server)
