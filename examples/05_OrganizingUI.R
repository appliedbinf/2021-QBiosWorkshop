library(shiny)

ui <- fluidPage(
    h1("Multiple Inputs"),
    fluidRow(
        column(
            width = 3,
            sliderInput(
                inputId = "num_pts",
                label = "Number of points",
                value = 100,
                min = 100,
                max = 1000000,
                step = 10
            )
        ),
        column(
            width = 3,
            sliderInput(
                inputId = "mean",
                label = "Mean",
                value = 0,
                min = -10,
                max = 10,
            )
        ),
        column(
            width = 3,
            sliderInput(
                inputId = "sdev",
                label = "Standard deviation",
                value = 1,
                min = 0,
                max = 10,
                step = 0.1
            )
        )
    ),
    plotOutput("simulation")
)

server <- function(input, output){
  output$simulation <- renderPlot({
    sim_dist = rnorm(n = input$num_pts, mean = input$mean, sd = input$sdev)
    plot(density(sim_dist), las=1, main = NA, xlab = NA, xlim = c(-20, 20))
    legend("topleft", legend = paste0(
      "N=", input$num_pts, "; mean=", input$mean, "; sd=", input$sdev),
      cex - 0.8
    )
  })
}

shinyApp(ui, server)
