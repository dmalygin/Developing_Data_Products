library(shiny)
library(shinyWidgets)

shinyCrimeRatesDataFrame <- read.csv(file="CitiesCrimeRates.csv", header=TRUE, sep=",")

# find min and max crime rate
crimeRateMin <- min(shinyCrimeRatesDataFrame[, 4])
crimeRateMax <- max(shinyCrimeRatesDataFrame[, 4])

# find min and max population
populationMin <- min(shinyCrimeRatesDataFrame[, 5])
populationMax <- max(shinyCrimeRatesDataFrame[, 5])

# build range for population and crime rate
populationTresholds <- c(populationMin, seq(from = 150000, to = 1550000, by = 50000), populationMax)
crimeRatesTresholds <- c(crimeRateMin, seq(from = 150, to = 950, by = 50), crimeRateMax)

shinyUI(fluidPage(

    titlePanel("Cities with the highest crime"),
    
    h4("For more details about the application and the data set preparation follow:"),
    
    a(href = "http://rpubs.com/DMalygin/crime_rates_presentation", "Presentation"),
    p("\n"),
    a(href = "http://rpubs.com/DMalygin/crime_rates", "Data preparation"),

    sidebarLayout(
        sidebarPanel(
            
            # limit setting
            sliderTextInput(
                   inputId = "populationRange", label = h4(tags$b("Population of the cities:")), 
                   choices = populationTresholds, selected = range(populationTresholds), 
                   grid = FALSE
            ),
            
            # limit setting
            sliderTextInput(
                   inputId = "crimeRateRange", label = h4(tags$b("Crime rates of the cities, per 100k:")), 
                   choices = crimeRatesTresholds, selected = range(crimeRatesTresholds), 
                   grid = FALSE
            ),
            
            # sorting
            radioButtons(
                   inputId = "sorting", label = h4(tags$b("Sort by:")),
                         choiceNames = list(
                             "Crime Rate (from lowest to highest)",
                             "Population (from lowest to highest)",
                             "State name (alphabetically)",
                             "City name (alphabetically)",
                             "Latitude (from South to North",
                             "Longitude (from West to East)"
                         ),
                         choiceValues = list(
                             "Crime_Rate", "Population", "State", "City", "Latitude", "Longitude")
            )
           
        ),


        mainPanel(

            plotOutput("distPlot"),
            tableOutput("view")
        )
    )
))
