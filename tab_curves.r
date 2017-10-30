tabCurves <- tabPanel("Explore Curves",

      sidebarLayout(
          sidebarPanel(h5(""),width = 3,

            checkboxGroupInput("SelectClimateCurves","Climate",c("temperate","tropical","mediteranean"),
                 selected=c("temperate","tropical","mediteranean") ),
            uiOutput("species"),
            sliderInput("TemperatureMDCurves", "Temperature", 0,40,value = c(0,40), step = 1,sep=""),
            uiOutput("Select_trt")
            #  h5(strong("Studied Treatments")), 
 
          ),
          
          mainPanel(

          	br(),
            h5("This tab shows each body growth curve separatly, with SE when available. You can export the selected data from the Export Data table."),
            h5("Above 10 growth curves, expect a significant delay before plots are rendered."),   
            verbatimTextOutput("my_sp"),
                  
            textOutput("curveNb"),
            br(),

            uiOutput("plots")
 

          ) # mainpanel
      )
    )