library(shiny)
library(babynames)

ui <- fluidPage(
  textOutput('env')
)

server <- function(input, output, session) {
  output$env <- renderText({
    capture.output(sessionInfo())
  })
}

shinyApp(ui, server)