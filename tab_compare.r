tabCompare <- tabPanel("Compare Curves",

  fluidRow(
        sidebarLayout(

    	    sidebarPanel(width = 3,
              br(),
    	   	    uiOutput("speciesCurves"),
      	       
    	        selectInput("ColorCurve", "Colour of the curves",choices=c("temperature","pH"),selected="temperature" ),

        	    sliderInput('plotHeight', 'Height of plots (in pixels)', 
                   min = 100, max = 800, value = 400),

        	    sliderInput('plotWidth', 'Width of plots (in pixels)', 
                   min = 100, max = 1000, value = 600)  	   
    	    ),

          mainPanel(
           	   h5("This tab allows you to compare growth curves within species."),
               h5("You can zoom in and manipulate the plots and change their size."),           
           	   h5("First choose a species, then a criteria to separate the curves. The separate plots are at the bottom of the page."),

           	   br(),

               h4("All Curves Together"),
               hr(),
               plotlyOutput("plotAllCurves")
    	    )

    	)
  ),

  fluidRow(
    sidebarLayout(

          sidebarPanel(width = 3,
             selectInput('facet_row', 'Separate curves by', c(Reference ="REF_ID",'Treatment type'="treatment_type"),selected="treatment_type")
             
          ),

          mainPanel(
               h4(textOutput("FacetCurve")),
               hr(),
               uiOutput("plotsComp"),
               br(),
               br()

          )
    )
  )

)