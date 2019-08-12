library(tidyverse)
library(lubridate)
library(reshape2)
library(readxl)

scenario_selector_mode = 1 # user pick 1 or 2

data1 = read_excel("scen_manager_test1.xlsx")
data2 = read_excel("scen_manager_test22.xlsx")

trainTestSplit = function (df){
  trainRowIndex = sample(1:nrow(df), 0.9*nrow(df))  
  trainData = df[trainRowIndex, ]
  testData  = df[-trainRowIndex, ] 
  return(list('trainData' = trainData, 'testData' = testData))
}


model1 = function(df){
  list2env(trainTestSplit(df), envir=.GlobalEnv)
  lm1 = lm(burn ~ scenario, data = trainData)
  pred = predict(lm1, testData) 
  return(pred)
}

model2 = function(df){
  list2env(trainTestSplit(df), envir=.GlobalEnv)
  lm2 = lm(value ~ scenario, data = trainData)
  pred = predict(lm2, testData) 
  return(pred)
}

scenarioOut = list()
scenarioList = list()


scenarioMan = function(df, scenario_selection){
  scenarioCt = length(unique(df$scenario)) # count how many scenario the user put
  scenarioList[[1]] = df %>% filter(scenario == 1)
  for (i in unique(df$scenario)){
    scenarioList[[i]] = df %>% filter(scenario == i)
  }
  
  if (scenario_selection == 1) {
    for(scen in seq(1,scenarioCt)){
      scenarioOut[[scen]] = model1(scenarioList[[scen]])
    }
  }
  
  if (scenario_selection == 2) {
    for(scen in seq(1,scenarioCt)){
      scenarioOut[[scen]] = model2(scenarioList[[scen]])
    }
  }
  return(scenarioOut)
}


scenarioOut = scenarioMan(data1,1)







