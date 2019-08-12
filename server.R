
library(shiny)
library(readxl)
library(tidyverse)
library(reshape2)

setwd("/Volumes/GoogleDrive/My Drive/Project/budget_corpStrat/budg_CS/scen_manager")

data1 = read_excel("scen_manager_test1.xlsx")
data2 = read_excel("scen_manager_test22.xlsx")


shinyServer(function(input, output) {
    
    data_show = reactive({
        if (input$radio ==1){
            return(data1)
        }else{
            return(data2)
        }
    })

    output$scenarioExample = renderDataTable(
        data_show(),
        options = list(
            pageLength = 10,
            initComplete = I("function(settings, json) {alert('Ashiyapp Bossque');}")
        )
        
        )
    
    }
)