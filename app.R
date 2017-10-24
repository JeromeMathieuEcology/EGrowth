# 26 09 2107
# author : jerome mathieu


library(shiny)
library(leaflet)
library(maptools)
library(plotly)
library(leaflet)
library(ggplot2)
#library(ggthemes)

data(wrld_simpl)



source("tab_home.r", local = TRUE)
source("tab_md.r", local = TRUE)
source("tab_curves.r", local = TRUE)
source("tab_help.r", local = TRUE)
source("tab_export.r", local = TRUE)
source("tab_compare.r", local = TRUE)

source("fit_loess.r", local = TRUE)

ui <- fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "sandstone.css")
  ),
  
  h3("EGrowth"),
  h3("A Database on Earthworm Body Growth Curves across the globe"),
  br(),
  tags$a("Contact: Jerome Mathieu , jerome.mathieu[at]upmc.fr"),
  br(),
  br(),
  
  tabsetPanel(
    tabHome,
    tabMD,  	
    tabCompare,
    tabCurves, 
    tabExport,  	
    tabHelp
  )
)




server <- function(input, output, session) {
  
  growth <- read.table("curves.txt",h=T,na.strings="na")
  EGrowth_metadata <- read.csv2("curves_md.csv",h=T,dec=".",na.strings="na",sep=",")
  
  EGrowth <- merge(growth,EGrowth_metadata,by="CURVE_ID")
  
  
  
  # --------------------------------------------------------------------------------------------------------
  #  tab Home ----------------------------------------------------------------------------------------------
  # --------------------------------------------------------------------------------------------------------
  
  output$Logo <- renderImage(list(src = normalizePath(file.path(".\\www\\images\\logo2.gif")),
                                  width = 531, #443,
                                  height = 205,#171,
                                  alt = paste("EGrowth")),
                             deleteFile = FALSE
  )
  
  
  
  # --------------------------------------------------------------------------------------------------------
  #  tab compare curves ------------------------------------------------------------------------------------
  # --------------------------------------------------------------------------------------------------------
  
  # species selector
    output$speciesCurves = renderUI({
      selectInput("Select_species_curves","Species",choices=levels(EGrowth$species))
    })
  
  # reactive dataframe
    dfCompCurves <- reactive({
      EGrowth[EGrowth$species==input$Select_species_curves,]
    })
  
  # list of groups to facet the plots (from reactive dataframe filtered by species)
    list_curves_Comp <- reactive ({
       levels(factor(dfCompCurves()[,input$facet_row]))
    })

  # plot all curves at once  
    output$plotAllCurves <- renderPlotly ({
        pall <- ggplot(dfCompCurves(),aes(x=time,y=bm,group=CURVE_ID,label=pH,label2=REF_ID,label3=treatment_level)) +
                      geom_smooth(se=F) +                
                      geom_point() +
                      aes_string(color=input$ColorCurve,alpha=0.8) +
                      guides(color=FALSE) +
                      labs(x = "Time (days)", y="Fresh Biomass (mg)") +
                      theme_minimal()
        ggplotly(pall,width = input$plotWidth, height = input$plotHeight)
    })
    
    
   # plot curves by groups   
    get_plot_output_list_Comp <- function(input_n) {    
      
      plot_output_list <- lapply(input_n, function(i) {
        
          #plotname <- paste("plot", i, sep="")

          #plot_output_object <- plotOutput(plotname)
          
          plot_output_object <- renderPlotly({
             p <- ggplot(dfCompCurves()[dfCompCurves()[,input$facet_row]==i,],            
                    aes(x=time,y=bm,group=CURVE_ID,label=pH,label2=REF_ID,label3=treatment_type,label4=treatment_level)) +
                    geom_smooth(se=F) +                
                    geom_point() +
                    aes_string(color=input$ColorCurve,alpha=0.8) +
                    guides(color=FALSE) +
                    labs(x = "Time (days)", y="Fresh Biomass (mg)") +
                    ggtitle(paste("\n",i)) +
                    theme_minimal()
            
             ggplotly(p,width = input$plotWidth, height = input$plotHeight)
            
          })
          
        
      })
      
      do.call(tagList, plot_output_list) # needed to display properly.
      
      return(plot_output_list)
    }
    
    
    observe({
      
      output$plotsComp <- renderUI({ get_plot_output_list_Comp(as.list(list_curves_Comp())) })
    })
    
    
  output$FacetCurve <- renderText(paste("Curves splitted by",input$facet_row)) 
  

  # --------------------------------------------------------------------------------------------------------
  #  tab MD ------------------------------------------------------------------------------------------------
  # --------------------------------------------------------------------------------------------------------
  
  # data prep --
  
  filteredMD_CY <- reactive({
    EGrowth_metadata[EGrowth_metadata$climate %in% input$SelectClimateMD & EGrowth_metadata$year >= input$YearMD[1] &
                       EGrowth_metadata$year <= input$YearMD[2]|is.na(EGrowth_metadata$year)  ,]
  })
  
  filteredMD_CYTTT <- reactive({
    filteredMD_CY()[filteredMD_CY()$temperature >= input$TemperatureMD[1] &
                      filteredMD_CY()$temperature <= input$TemperatureMD[2]|is.na(filteredMD_CY()$temperature) ,]
  })
  
  #nbCurves <- reactive ({  })
  
  
  tableSp <- reactive({ 
    tableSp <- as.data.frame(apply(table(filteredMD_CYTTT()$species,filteredMD_CYTTT()$CURVE_ID),1,sum))
    tableSp <- data.frame(row.names(tableSp),tableSp)
    names(tableSp) <- c("species","Number of curves")
    return(tableSp)
  })
  
  tableTrt <- reactive({ 
    tableTrt <- as.data.frame(table(filteredMD_CYTTT()$treatment_type))
    names(tableTrt) <- c("Treatment","Number of curves")
    return(tableTrt)
  })

  
  # ouputs --------------
  output$TableTrtType <- renderTable(tableTrt())
  output$NbCurves <- renderText(dim(filteredMD_CYTTT())[1])
  output$NbSp <- renderText(nlevels(factor(filteredMD_CYTTT()$species)))
  output$trt <- renderText(list_trt_type)
  output$TableNsp <- renderTable(tableSp())
  output$NbPoints <- renderText(nrow(growth[growth$CURVE_ID %in% filteredMD_CYTTT()$CURVE_ID,]))

    
  # leaflet map -------------------------
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addProviderTiles("CartoDB.Positron",#Stamen.TonerLite
                       options = c(providerTileOptions(noWrap = TRUE))) %>% 
      addMarkers(data =  filteredMD_CYTTT(),
                 popup=paste(strong("Source:") ,gsub("_"," ",filteredMD_CYTTT()$REF_ID),"<br>",
                             strong("Species:"),em(filteredMD_CYTTT()$species),"<br>",
                             strong("Treatment Type:"),filteredMD_CYTTT()$treatment_type)) %>% 
      setView(4, 30, zoom = 2)
  })
  # plots ---
  
  # hist year of publi
  output$plotYear <- renderPlotly({
    plot_ly(data = filteredMD_CYTTT(),x=~year, type = "histogram")
  })
  
  # hist temperature  
  output$plotTemp <- renderPlotly({
    plot_ly(data = filteredMD_CYTTT(),x=~temperature, type = "histogram")
  })
  # hist pH
  output$plotPh <- renderPlotly({
    plot_ly(data = filteredMD_CYTTT(),x=~pH, type = "histogram")
  })
  
  
  # --------------------------------------------------------------------------------------------------------
  # tab export ---------------------------------------------------------------------------------------------
  # --------------------------------------------------------------------------------------------------------
  
  output$DLselectedCurves <- downloadHandler(filename = "EGgrowth_curves.csv",
                                             content = function(file) {write.csv(selectedCurves(), file, row.names = FALSE) })
  
  output$DLselectedMD  <- downloadHandler(filename = "EGgrowth_curves_md.csv",
                                          content = function(file) {write.csv(selectedMD(), file, row.names = FALSE) })                                             
  
  
  # --------------------------------------------------------------------------------------------------------
  # tab curves ---------------------------------------------------------------------------------------------
  # --------------------------------------------------------------------------------------------------------
  
  
    # select data and construc list of curves
  
      list_sp <- reactive({  levels(factor(EGrowth_metadata[EGrowth_metadata$climate %in% input$SelectClimateCurves ,]$species))  })
      
      list_trt <- reactive({  levels(factor(EGrowth_metadata[
        EGrowth_metadata$climate %in% input$SelectClimateCurves,]$treatment_type)) }) 
      
      
      list_curves_CSpTrt <- reactive ({ 
        EGrowth_metadata$CURVE_ID[
          EGrowth_metadata$climate %in% input$SelectClimateCurves &
            EGrowth_metadata$species == input$Select_species &
            EGrowth_metadata$treatment_type %in% input$Select_trt] })
      
      selectedCurves <- reactive ({ growth[growth$CURVE_ID %in% list_curves_CSpTrt(),] })
      selectedMD <- reactive( { EGrowth_metadata[EGrowth_metadata$CURVE_ID %in% list_curves_CSpTrt(),] } )
      
      
      
      
      # section to build the dynamic plots    
      # --------------------------------------------------------------------------------
      
      
      get_plot_output_list <- function(input_n) {    
        
        plot_output_list <- lapply(input_n, function(i) {

          XX <- growth[growth$CURVE_ID==i,c("bm","time")]
          YY <- fit_loess(XX)
          
          
          plot_output_object <- renderPlot({
            
            layout(rbind(c(1,2),
                         c(1,0),
                         c(1,3),
                         c(4,4)),
                   heights=c(3.5,lcm(0),3)#,
            )
            
            plot(growth$time[growth$CURVE_ID==i],growth$bm[growth$CURVE_ID==i],  
                 ylab="Biomass (mg)",xlab="time (days)",pch=20,col="grey30",cex=2,
                 cex.lab=1.7,cex.axis=2,bty="n",
                 ylim=c(0,max(growth$bm[growth$CURVE_ID==i]+growth$SE[growth$CURVE_ID==i]+2,growth$bm[growth$CURVE_ID==i],na.rm=T))
            ) #,cex.main=2
            
            lines(YY$time,YY$bm,col=rgb(t(col2rgb("tomato2"))/256,alpha=.4),lwd=4)
            legend("topleft",legend=c(paste("CURVE_ID: ", i, sep = ""),
                                      paste("Treat.:",gsub("X |<br>","\n",EGrowth_metadata$treatment_level_br[EGrowth_metadata$CURVE_ID==i] ),sep=" ")),
                   text.col="grey30",cex=1.5,box.lwd=0,bty="n")
            
            segments(growth$time[growth$CURVE_ID==i], 1.05*growth$bm[growth$CURVE_ID==i], growth$time[growth$CURVE_ID==i],
                     growth$bm[growth$CURVE_ID==i] + growth$SE[growth$CURVE_ID==i], lwd = 1.5,lend="round")
            
            segments(growth$time[growth$CURVE_ID==i], 0.95*growth$bm[growth$CURVE_ID==i], growth$time[growth$CURVE_ID==i],
                     growth$bm[growth$CURVE_ID==i] - growth$SE[growth$CURVE_ID==i], lwd = 1.5,lend="round")
            
            # plot map ---
            par(mar=c(0,0,1,0))
            plot(wrld_simpl,axes=F,col="antiquewhite2",border="grey70")#,xaxt='n', ann=FALSE,yaxt='n'
            points(EGrowth_metadata$long[EGrowth_metadata$CURVE_ID==i],EGrowth_metadata$lat[EGrowth_metadata$CURVE_ID==i],pch=20,col="tomato1",cex=2)
            
            # plot MetaData ---
            par(mar=c(1,1,0,0))
            plot(1,cex=0,xlim=c(0,1),axes=F,ann=FALSE, xaxt='n')
            
            text(.1,1.3,paste("Temperature:",EGrowth_metadata$temperature[EGrowth_metadata$CURVE_ID==i],"°C", sep=" "),cex=1.8,pos=4)
            text(.1,1.2,paste("Humidity:",paste(EGrowth_metadata$moisture, EGrowth_metadata$moisture_type)[EGrowth_metadata$CURVE_ID==i],sep=" "),cex=1.8,pos=4)                       
            text(.1,1.1,paste("pH:",EGrowth_metadata$pH[EGrowth_metadata$CURVE_ID==i],sep=" "),cex=1.8,pos=4)   
            text(.1,1.0,paste("Density:",EGrowth_metadata$focus_density[EGrowth_metadata$CURVE_ID==i],"ind. per container",sep=" "),cex=1.8,pos=4)
            text(.1,0.9,paste("Reference:",gsub("_"," ",EGrowth_metadata$REF_ID[EGrowth_metadata$CURVE_ID==i] ),sep=" "),cex=1.8,pos=4)                                                               
            text(.1,0.8,paste("Treatment type:",EGrowth_metadata$treatment_type[EGrowth_metadata$CURVE_ID==i],sep=" "),cex=1.8,pos=4)                                
            
            # plot horizontal bar
            plot(1,cex=0,xlim=c(0,1),axes=F,ann=FALSE, xaxt='n')
            abline(1,0,col="azure3")
            
            
          })
          
        })
        
        do.call(tagList, plot_output_list) # needed to display properly.
        
        return(plot_output_list)
      }
      
      
      observe({
        
        output$plots <- renderUI({ get_plot_output_list(as.list(list_curves_CSpTrt())) })
      })
      
   # --------------------------------------------------------------------
      
      # outputs
      output$dfselectedCurves <- renderTable(selectedCurves())
      output$selectedMD <- renderTable(EGrowth_metadata[EGrowth_metadata$CURVE_ID %in% list_curves_CSpTrt(),])  
      
      
      # selectors
      output$species = renderUI({
        selectInput("Select_species","Species",choices=list_sp())
      })
      
      output$Select_trt = renderUI({
        checkboxGroupInput("Select_trt","Treatment",choices=list_trt(),selected=list_trt())
      })
      
      output$curveNb <- renderText(paste(length(list_curves_CSpTrt()),"growth curves selected") ) 
      #output$TableCurves <- renderText(dim(filteredCurves_CSpTrt()))
      output$my_sp <- renderText(input$Select_species)
      
  
  
  
}


shinyApp(ui, server)

