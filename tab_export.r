tabExport <- tabPanel("Export Data",
	
 #    br(),

	# splitLayout(cellWidths = c("25%", "5%","70%"),
 #      strong("raw data"),
 #      h5(" "),
 #      strong("metadata")
	# ),

    br(),
    h5("Export data selected in Explore Growth Curve Tab."),
	  splitLayout(cellWidths = c("25%", "5%","70%"),
      downloadButton("DLselectedCurves","Growth Curves (.csv)"),
      h5(" "),
      downloadButton("DLselectedMD","metadata (.csv)")
    ),

    br(),


    splitLayout(cellWidths = c("25%", "5%","70%"),
        tableOutput("dfselectedCurves"),
        h5(" "),
        tableOutput("selectedMD")
    )

)