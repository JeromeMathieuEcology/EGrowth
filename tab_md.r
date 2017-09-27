tabMD <- tabPanel("Metadata",

          sidebarLayout(

            sidebarPanel(h5(""),width = 3, 

              checkboxGroupInput("SelectClimateMD","Climate",c("temperate","tropical","mediteranean"),
                 selected=c("temperate","tropical","mediteranean") ),

              sliderInput("YearMD", "Year", 1950,2016,value = c(1950,2016), step = 1,sep=""),
              sliderInput("TemperatureMD", "Temperature", 0,40,value = c(0,40), step = 1,sep="")#,
              #h5(strong("Studied Treatments")),   
              
            ),
            
            mainPanel(
              h5("This tab summarizes the studies included in the EGrowth database."),
              h5("You can select studies with the checkboxs and sliders on the left."),
              hr(),
              splitLayout(cellWidths = c("33%", "33%","33%"),cellHeights=50,
                #h4("b1"),
                #h4("b2"),
                #h4("b3")  
                #plotOutput("plot1", width = "100%"),
                plotlyOutput("plotYear", width = "100%", height = "200px"),       
                plotlyOutput("plotTemp", width = "100%", height = "200px"),
                plotlyOutput("plotPh", width = "100%", height = "200px")
              ),
              br(),
              hr(),
              fluidRow(
                splitLayout(cellWidths = c("10%", "40%","50%"),
                  h5(""),
                  h5(strong("Number of Species selected")),
                  h5(strong("Number of corresponding curves"))
                )
              ),

              fluidRow(
                splitLayout(cellWidths = c("10%", "40%","50%"),
                  h5(""),
                  textOutput("NbSp"),
                  textOutput("NbCurves")
                )
              ),
              hr(),
              h4("Origin of the growth curves"),
              leafletOutput("mymap", width = 700, height = 400),
              tags$a("click on the markers to get information about the data"),
              
              br(),
              hr(),
              
              fluidRow(
                splitLayout(cellWidths = c("45%","55%"),
                  h5("Number of curves per species"),
                  #h5(""),
                  h5("Number of curves per treatment type")
                )
              ),

              fluidRow(
                splitLayout(cellWidths = c("45%", "55%"),         
                  div(tableOutput("TableNsp"), style = "font-size:70%"),
                 # h5(""),
                  div(tableOutput("TableTrtType"), style = "font-size:70%")
                )
              )
            )
          )     
    )