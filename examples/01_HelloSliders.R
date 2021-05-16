library(shiny)

# Required UI object for the Frontend.
ui <- fluidPage(
    h1("Hello sliders!"),
    sliderInput(
        inputId = "alpha",
        label = "Strength of shielding",
        value = 10,
        min = 0,
        max = 20,
        step = 0.2
    )
)

# Required server function for the backend
server <- function(input, output) {
}

# Shiny application instance consisting of a front and backend
shinyApp(ui, server)

