library(shiny)


shinyCrimeRatesDataFrame <- read.csv(file="CitiesCrimeRates.csv", header=TRUE, sep=",")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    subsetDataFrame <- reactive({
        
        #subsetting
        subsettedDataFrame <- (subset(shinyCrimeRatesDataFrame,
                shinyCrimeRatesDataFrame$Population >= input$populationRange[1] & 
                    shinyCrimeRatesDataFrame$Population <= input$populationRange[2] &
                    shinyCrimeRatesDataFrame$Crime_Rate >= input$crimeRateRange[1] &
                    shinyCrimeRatesDataFrame$Crime_Rate <= input$crimeRateRange[2]))
        
        
        # sorting
        if(input$sorting == "Crime_Rate") {
            sortByColumn <- subsettedDataFrame$Crime_Rate
        }
        if(input$sorting == "Population") {
            sortByColumn <- subsettedDataFrame$Population
        }
        if(input$sorting == "State") {
            sortByColumn <- subsettedDataFrame$State
        }
        if(input$sorting == "City") {
            sortByColumn <- subsettedDataFrame$City
        }
        if(input$sorting == "Latitude") {
            sortByColumn <- subsettedDataFrame$Latitude
        }
        if(input$sorting == "Longitude") {
            sortByColumn <- subsettedDataFrame$Longitude
        }
        
        subsettedDataFrame[order(sortByColumn), ]
    })


    
    #output barplot
    output$distPlot <- renderPlot({
        barplot(subsetDataFrame()$Crime_Rate,
                names.arg = subsetDataFrame()$City,
                main = "Crime rate, per 100k people",
                ylab = "Crime rate, per 100k people",
                ylim = range(pretty(c(0, max(subsetDataFrame()[, 4])))),
                cex.names = 0.7,
                las = 2)
        if(input$sorting == "Crime_Rate") {
            medHigh <- median(subsetDataFrame()$Crime_Rate)
            abline(h = medHigh, col="red", lwd=3, lty=2)
            text(medHigh + 40, capture.output(cat('               
                                                  Median (crime rate) = ', medHigh)), col = "red")
        }
    })
    
    # output table
    output$view <- renderTable({
        subsetDataFrame()
    })

})
