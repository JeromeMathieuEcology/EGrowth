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
    column(width = 7,offset = 2, 
            br(),
           
            strong(em("Welcome to the EGrowth database GUI v.1")),
            br(),            

            h5("The EGrowth database is designed to make comparative analysis of body size in the earthworm group, and to model Intraspecific
               body size variability (IBSV) in relation to environmental predictors."),
            h5("Most species' traits beeing proportional to body size, the EGrowth database should help tackling the role of Intraspecific Trait variability (ITV) in earthworm."),
            br(),

            h5("The EGrowth database comprises more than 1000 body growth curves -- biomass of individuals at several dates -- of earthworm and covers more than 50 from species across the globe. Data
             are compiled from a combination of published literature and other sources such as PhD thesis and reports.
             Each curve is given with metadata that contains the experimental and environmental conditions in which the curves were produced."),
            br(),

            h5("The database has been published in 2018 in Soil Biology and Biochemistry: "),
            p(a("https://doi.org/10.1016/j.soilbio.2018.04.004")),
            h5("The database can also be browsed from the R console. To do so please refer to the detailed User Guide published as as a supplementary material of the paper in SBB."),
            br(),       

            h5("You will find four panels to explore the database:"),
            br(),            

            strong("Metadata"),
            tags$ul(
              h5("This panel summarizes the data available in the database: 
                 environmental conditions studied, location of the studies, and so on.")
            ),
            br(),

            strong("Compare curves"),
            tags$ul(
              h5("This panels allows you to compare growth curves within species: Intraspecific
               body size variability (IBSV)."),
               h5("You can compare species by treatment level."),
               h5("Curves can be grouped by treatment type or by publication.")
            ),
            br(),

            strong("Explore curves"), 
            tags$ul(
              h5("This panel allows you to explore individual growth curves by species. You can select the   
                  environmental conditions in which the curves were produced.")
            ),
            br(),

            strong("Export Data"),
            tags$ul(
              h5("In this panel you can export the data selected in the explore curves panel.")
            ),
            br(),
            
            strong("Any question?"), 
            h5("See the help section or send me an email!"),
            h5("Remember to read the paper in SBB and the User Guide")
            
    )
  )   
)
