library(shiny)

ui <- navbarPage( # Make a navbar page, previously we've used fluidPage
  title = "Hello Navbar!", # Application name
  id = "navbar",
  # Each tabPanel is "page" in our app, only one panel is visible at a time 
  tabPanel(title = "Tab 1", # Name of tab, appears in navbar
        "Hello from Tab 1"), # Tab content, just like the Hello World example
  tabPanel("Tab 2",
           "Hello from Tab 2")
)

server <- function(input, output){}


shinyApp(ui, server)
