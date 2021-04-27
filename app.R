# install.packages('leaflet')
# install.packages('tidyverse')

library(shiny)
library(shinyWidgets)
library(tidyverse)
library(leaflet)

# source https://simplemaps.com/data/us-cities
# cities = read_csv("uscities.csv")
# cities = read_csv('data_scaled_by_10_000.csv')
cities = read_csv('uscities_data_scaled_by_10_000.csv')
dist_centers = read_csv("UPS-Fedex Locations.csv")
cities = cities %>% filter(state_name != "Alaska") %>% filter(state_name != "Hawaii") %>% filter(state_name != "Puerto Rico")
locations = cities %>% select(lat,lng)

# Define UI
ui <- fluidPage(
    
    # App title ----
    titlePanel("Optimal Distribution Centers using Kmeans for U.S. Cities"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar to demonstrate K means slider 
        sidebarPanel(
            
            # Input: Simple integer interval ----
            sliderInput("cluster", "Number of clusters:",
                        min = 0, max = 20,
                        value = 7),
            br(),
            awesomeCheckboxGroup(
                inputId = "distribution_centers",
                label = "Select Which Distribution Centers to Display", 
                choices = c("Fedex", "UPS"),
                selected = c("Fedex", "UPS")
            )
            
        ),
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Table summarizing the values entered ----
            leafletOutput("mymap"),
            p(),
            plotOutput("myPlot")
            
        )
    )
)

# Define backend
server <- function(input, output, session) {
    
    # Creates reactive clusters. Every time the slider is moved, the model is rerun.
    clusters <- reactive({
        kmeans(locations,input$cluster)
        
        # Weighted K means attempt. Need to look into library documentation.
        # library(wskm)
        # ewkm(locations,input$cluster)
        
    })
    
    dist_center_data <-  reactive({
        
        dist_centers %>% filter(type %in% input$distribution_centers)
    })
    # Renders map and markers based on the number of clusters selected. 
    
    output$mymap <- renderLeaflet({
        
        map_data = as.data.frame(clusters()$centers)
        map_data$type = "predicted"
        all_data = union(map_data,dist_center_data())
        # filtered_data = all_data %>% filter(type %in% input$distribution_centers)
        
        Icons <- iconList(
            Fedex =  makeIcon(
                iconUrl = "FedEx_logo.png",
                iconWidth = 30, iconHeight = 30
            ),
            UPS = makeIcon(
                iconUrl = "ups-logo-0.png",
                iconWidth = 50, iconHeight = 50
            ),
            predicted = makeIcon(
                iconUrl = "prediction_marker.png",
                iconWidth = 50, iconHeight = 50
            )
        )
        
        leaflet(data = all_data) %>%
            addTiles() %>%
            addMarkers(lng = ~lng ,lat = ~lat, popup = ~as.character(paste(lat,lng, sep = ",")),icon = ~Icons[type])

        
        # leaflet(data = clusters()) %>%
        #     addTiles() %>%
        #     addMarkers(lng=clusters()$centers[,2] ,lat=clusters()$centers[,1], popup = toString(clusters()$centers))
    })
    
    
    output$myPlot <- renderPlot({
        
        # function to compute total within-cluster sum of square 
        set.seed(1234)
        wss <- function(k) {
            kmeans(locations,k)$tot.withinss
        }
        
        # Compute and plot wss for k = 1 to k = 20
        k.values <- 1:20
        
        # extract wss for 2-20 clusters
        wss_values <- map_dbl(k.values, wss)
        
        plot(k.values, wss_values,
             type="b", pch = 19, frame = TRUE, 
             xlab="Number of clusters K",
             ylab="Total within-clusters sum of squares",
             main = "Elbow Chart for determining number of ideal clusters")
    })
}



shinyApp(ui, server)

########################################




