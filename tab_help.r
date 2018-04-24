tabHelp <- tabPanel("Help",
 
 fluidRow( 


  column(width = 8,offset = 1, 
    br(),
    h5("In this App you will find different panels to explore the database"),
    br(),

   strong("Panel 'Metadata'"),
      tags$ul(
          h5("This panels summarizes the data available in the database: 
            environmental conditions studied, location of the studies, and so on"),
          h5("On the left you can select the conditions in which the curves were produced"),
          h5("Below that you will find a contingency table that summarizes the treatment that were studied
           in the corresponding curves"),
          h5("The first column describes the type of treatment, the second tells the number of curves that
           studied this kind of treatment"),
          
          h5("On the right, you will find three plots on the first row. The are histogramms of the year
           of publication, temperature and ph of the substrate in the selected growth curves"),
          h5("Second line tells the number of species selected, and the number of curves selected"),
          h5("Last, you will find a map of the location of the specimens used to produce the curves. 
            You can zoom and pan the map."),
          h5("You can also click on the markers to get information on the curves")
      ),
      
      br(),
   strong("Panel 'Compare Curves' "),
      tags$ul(
          h5("This panels allows you to compare body growth curve within species."),
          h5("Growth curves can be grouped by type of treatment or by publication. "),
          h5("Growth curves can be colored by type of temperature of pH. They appear in gray
           if the information is missing. ")
        ),
      br(),


    strong("Panel 'Explore curves'"), 
      tags$ul(    
          h5("This panel allows you to explore individual growth curves
            -- biomass of individuals at several dates -- 
            in a variety of conditions and environmental conditions, for different species."),

          br(),
          h5("You can select the growth curves either by selecting"),
          h5("- The climate from which the individuals come from"),
          h5("- The species studied (mandatory)"),
          h5("- The type of treatment that was studied"),
          br(),
          h5("Please note that when there are many curves selected, typically above 10,
            it will take time for the application to draw the plots. 
            Please be patient and do not click on any buttons, otherwise it will make it worse!"),
          br(),
          h5("The panel shows the following information:"),
          h5("- The number of growth curves corresponding to you criteria"),
          h5("- The species that you selected"),
          h5("- The left column shows the raw data, with a loess fit in red. The ID of the curve is mentionned,
           as well as the treatment type"),
          h5("- The right column shows a map with the origin of the individuals used to produce the curve
           (this is not necessary were the exeperiment was performed)"),
          h5("- Below the map, environmental conditions used to produce the curve, 
            and the source of the curve, are summarized.")
      ),
      br(),
      br(),

      strong("Panel 'Export data'"),
      tags$ul(
          h5("This tab allows you to export the curves selected in the Explore curves panel")
      ),
      br(),

      strong("WARNINGS"),
       tags$ul(
        h5(strong("- The 'time' axis should not be interpreted as 'age'."),"
          The age at time = 0 varies from curve to curve and rarely is the day of birth." ),
        h5(strong("- Species names"),"should be interpreted in ligth of recent advances on earthworm taxonomy,
          particularly regarding", strong("cryptic species")," in species complexes such as",tags$em("A. caliginosa"),".")
        ),
      br(),
   
      strong("USING THE DATABASE FROM R"),
      tags$ul(
        h5("This database can also be browsed from the R console. I actually recommend  to browse the database this way"),
        h5("- For this you need to install the shiny package"),
        code("if (!require('shiny')) install.packages('shiny')"),
        h5("- Then load the package"),
        code("library(shiny)"),
        h5("- Then type:"),
        code("runGitHub('EGrowth', 'JeromeMathieuEcology')"),
        h5("The GUI should open in you default browser")
      ),
      br(),
   

      strong("Code of the Application"), 
      tags$ul(    
          h5("The code of this application is available on Zenodo:", a("https://zenodo.org/record/1039952")),
          br()
      )
    ) 
  
 )
)
