## Bedbugs
***


## Project Background

This project is associated with the SESYNC Pursuit "The Sociospatial Ecology of Bedbugs". Our project connects population biologists, urban planners, and health researchers to examine the interrelationship between bedbug and human populations, municipal regulation, and pest management approaches.

![](http://www.deadpestz.com/wp-content/uploads/2017/11/babybedbugs.jpg)

***

## Summer Institute Goals
* Import public database of municipal code violations associated with bedbugs (public data are available via municipal APIs)
* Assess the seasonality of bedbug complaints
* Develop a mapping application that allows for the querying and spatial visualization of violations using ```Shiny```
* Add to mapping and analytical outputs demographic information drawn from Census and American Community Survey data
* (maybe) develop predicted probabilities of future clusters of bedbug infestations based upon certain criteria

## Summer Institute Progress
* **Import public database of municipal code violations associated with bedbugs (public data are available via municipal APIs)**

    + We were able to use the ```RSocrata``` package to programmatically download code violation data from the Chicago and New York City public data APIs. This could eventually be automatically updated by running a recurring download call (every week?) that queries only new violations posted after the previous update. Right now we are donwloading all code violations, which result in a lot of data, but we might begin to query only violations pretaining to pests.

    + We also made use of text evaluation tools such as ```grepl``` to classify violations based upon whether they mention bedbugs or not. Perhaps this is eventually an area where supervised machine learning could be applied?

* **Assess the seasonality of bedbug complaints**

    + We used several aggregation functions to transform individual violation listings into a time series that could be aggregated by a specific time unit (e.g. month), and decomposed these listings to determine the trend, seasonal, and random components for each month. This will help us to think about how policies and other exogenous factors may be influencing the presence or absence of bedbug populations (or the prevalance of households caling to complain or for inspectors to cite around bedbugs).

* **Develop a mapping application that allows for the querying and spatial visualization of violations using Shiny**

    + We used latitude and longitude information contained within the violation data to transform our listings into a ```sf``` object. We then mapped using the leaflet package. We also created a design for a web application driven by ```Shiny``` which includes a map of violations, corresponding violation numbers, and information on each specific violation which occurred during a user-selectable time period (still working to make this user-selectable).

* **Add to mapping and analytical outputs demographic information drawn from Census and American Community Survey data.**

    + We downloaded ACS data from the Census API using the ```tidycensus``` package and joined it with corresponding geographic boundaries also downloaded programmatically from the Census API using the ```tigris``` package. We then performed a spatial join to attach tract sociodemographic information to each instance of a pest or bedbug violation. We will eventually integrate this into our shiny interface so that as users select particular time periods, the application can calculate the average sociodemographic characteristics for the housing units associated with the user-selected violations.

## Public Data Sources
* Chicago [(link)](https://data.cityofchicago.org/api/views/22u3-xenr/rows.csv?accessType=DOWNLOAD)
* New York City [(link)](https://data.cityofnewyork.us/api/views/gih3-4epm/rows.csv?accessType=DOWNLOAD)

## Collaborators
* Claudia Arevalo
* Andrew Greenlee, University of Illinois at Urbana Champaign [(agreen4@illinois.edu)](mailto:agreen4@illinois.edu)
* Kate Hacker, University of Pennsylvania [(Kathryn.Hacker@pennmedicine.upenn.edu)](Kathryn.Hacker@pennmedicine.upenn.edu)



