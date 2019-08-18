Course Project: Shiny Application and Reproducible Pitch
========================================================
author: DMalygin
date: 08/17/2019
autosize: true

Overview
========================================================
<style>
.reveal h4 {font-size: 25px; color: blue;}
.reveal ul, .reveal ol {font-size: 20px;}
</style>

#### The goals of the application:
- Demonstrate usage of:
  + Shiny control elements such as sliders, radiobattons
  + Shiny widgets such as barplots, tables

#### To demonstrate work of the aplication the following elements were implemented:
- UI part:
  + Setting of ranges with sliders
  + Sorting variants of data frame columns with radiobuttons
  
- Server part:
  + Interactive Bar plotting
  + Interactive Table creation



Data
========================================================
class: small-code
<style>
.small-code pre code {font-size: 20px;}
.reveal h4 {font-size: 25px;}
</style>

#### Data used in this project shows USA cities with highest crime rate per state:

```r
shinyCrimeRatesDataFrame <- read.csv(file="CitiesCrimeRates.csv", header=TRUE, sep=",")

head(shinyCrimeRatesDataFrame)
```

```
           State        City Year Crime_Rate Population Latitude Longitude
1 SOUTH CAROLINA  CHARLESTON 2017        134     136845  32.8179  -79.9589
2          IDAHO       BOISE 2017        142     225677  43.5985 -116.2311
3   NORTH DAKOTA       FARGO 2017        169     123430  46.8652  -96.8290
4       KENTUCKY   LEXINGTON 2017        172     322332  38.0402  -84.4584
5      WISCONSIN   GREEN BAY 2017        200     105331  44.5207  -87.9842
6   SOUTH DAKOTA SIOUX FALLS 2017        216     177888  43.5383  -96.7320
```

#### It was taken from:
#### 1. https://ucr.fbi.gov/crime-in-the-u.s/2018/preliminary-report/tables (table 4; Offenses Reported to Law Enforcement, by State by City 100,000 and over in population) https://ucr.fbi.gov/crime-in-the-u.s/2018/preliminary-report/ (describtion of the data and specific assumptions)
#### 2. https://www.downloadexcelfiles.com/wo_en/download-list-latitutelongitude-cities-usa (MS Excel(2007); List of Latitude/Longitude of Cities of USA)

#### *Information about data preparation can be obtained here: http://rpubs.com/DMalygin/crime_rates




Work of the application
========================================================
class: small-code
<style>
.small-code pre code {font-size: 20px;}
.reveal h4 {font-size: 25px; color: black;}
</style>
#### Since the goal of the project was to study how to build the Shine application, the work of the one is intuitively understandable going to the link: https://dmalygin.shinyapps.io/myapp/

#### The most interesting part of the application is interaction between UI and Server part in order to subset and order the data frame for plotting (shortened version of the reactive element):

```r
    #subsetDataFrame <- reactive({
    #    
    #    #subsetting
    #    subsettedDataFrame <- (subset(shinyCrimeRatesDataFrame,
    #            shinyCrimeRatesDataFrame$Population >= input$populationRange[1] & 
    #                shinyCrimeRatesDataFrame$Population <= input$populationRange[2] &
    #                shinyCrimeRatesDataFrame$Crime_Rate >= input$crimeRateRange[1] &
    #                shinyCrimeRatesDataFrame$Crime_Rate <= input$crimeRateRange[2]))
    #    
    #    
    #    # sorting
    #    if(input$sorting == "Crime_Rate") {
    #        sortByColumn <- subsettedDataFrame$Crime_Rate
    #    }
    #    
    #    # output
    #    subsettedDataFrame[order(sortByColumn), ]
    #})
```


Output
========================================================
class: small-code
<style>
.small-code pre code {font-size: 15px;}
.reveal h4 {font-size: 15px; color: black;}
</style>
#### As a result of the application work the following plot is built (default version).
#### Since the application uses reactive element the plot rebuilds when range and sorting parameters changes.


```r
shinyCrimeRatesDataFrame <- read.csv(file="CitiesCrimeRates.csv", header=TRUE, sep=",")

barplot(shinyCrimeRatesDataFrame$Crime_Rate,
                names.arg = shinyCrimeRatesDataFrame$City,
                main="Crime rate, per 100k people",
                ylab="Crime rate, per 100k people",
                cex.names=0.7,
                las=2)
```

<img src="myPresentation-figure/unnamed-chunk-3-1.png" title="plot of chunk unnamed-chunk-3" alt="plot of chunk unnamed-chunk-3" width="500px" height="350px" />














