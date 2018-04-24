tabCite <- tabPanel("Citation",
 
  fluidRow(
  	column(width = 10,offset = 2,
  		br(),
	  	strong("How to cite the EGrowth database"),   
	  	h5("Building this database has been a tremendous work,"),  
	  	h5("So please cite the database if you use it!"),  

		br(),
	  	
	  	tags$ul(
  			strong("Reference of the paper"),
  	  	h5("Jerome Mathieu"),
  	  	h5("EGrowth: A global database on intraspecific body growth variability in earthworm"), 
  	  	h5("Soil Biology and Biochemistry, Volume 122, July 2018, Pages 71-80"),
  	  	a("https://doi.org/10.1016/j.soilbio.2018.04.004")
	  	),
      br(),
	  	
	  	tags$ul(
  			strong("Code and Reference of the App"),
	   		h5("They can be found on Zenodo:"),
	  		p(a("https://zenodo.org/record/1039952")),
  			HTML('<a href="https://doi.org/10.5281/zenodo.1039952"><img src="https://zenodo.org/badge/DOI/10.5281/zenodo.1039952.svg" alt="DOI"></a>')
	  	),
	    br(),

		  h5("I will be more than happy to list papers that cite this database."),
	    h5("Thanks in advance."),
	    h5("Jerome")
    )

  )

)
