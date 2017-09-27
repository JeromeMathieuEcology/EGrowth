tabHome <- tabPanel("Home",
 
  fluidRow( 
    
    column(width = 8,offset = 2,
       br(),
       br(),#,
      #HTML('<center><img src=".\\www\\images\\logo2.gif"></center>')
       #imageOutput("Logo",height = "150px")
       img(src = 'logo2.gif', height = '200px', width = '530px')
    )
  ),    
  
  fluidRow( 
    column(width = 8,offset = 2, 
            br(),
            strong(em("Welcome to the EGrowth database")),
            br(),
            h5("The EGrowth database comprises data on body growth curves of earthworm species across the globe. Data
             are compiled from a combination of published literature and other sources such as PhD thesis and reports.
             The data reports growth curves -- biomass of individuals at several dates -- in a variety of conditions and
             environmental conditions."),
            br(),
            h5("You will find two panels to explore the data"),
            br(),
            strong("Explore growth curves"), 
            h5("This panel allows you to explore individual growth curves. You can select the   
              environmental conditions in which the curves were produced and the species studied."),
            br(),
            strong("Metadata"),
            h5("This panels summarizes the data available in the database: 
              environmental conditions studied, location of the studies, and so on."),
            br(),
            h5("You can export the data with the Export data panel"),
            br(),
            h5("Any question? see the help section or send me an email.")
    )
  )   
)