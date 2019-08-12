
library(shiny)

shinyUI(fluidPage(
    titlePanel("Just For Practice on Scenario Manager"),
    
    sidebarLayout(
        position = 'left',
        sidebarPanel(helpText("Please select your scenario type, and then pay attention closely on the example that will be loaded"),
                     radioButtons("radio",
                                  h3("Scenario Mode"),
                                  choices = list("Simple" = 1, "Granular" = 2),
                                  selected = 1)),
        mainPanel(
            fileInput("file", h3("Scenario input"))
        )
        
        ),
    
    mainPanel(
        dataTableOutput("scenarioExample")
        )
    )
)
