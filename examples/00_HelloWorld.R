library(shiny)

# Required UI object for the Frontend. This holds the user interface layout
# and graphical and interactive elements
ui <- fluidPage("Hello world!")

# Required server function for the backend
server <- function(input, output) {
}

# Shiny application instance consisting of a front and backend
shinyApp(ui, server)
