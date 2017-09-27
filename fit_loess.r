
# X = data frame for a given curve, with columns = "time" and "bm"

fit_loess <- function(X){ 

    loess_test <- loess(bm~time,data=X,span = 0.8)
    Xmax <- max(X$time) 
    newTime <- seq(0,Xmax,1)
    newTime <- data.frame(time=newTime)

    bmTheoric <- predict(loess_test,newTime)
    bmTheoric <- data.frame(time=newTime,bm=bmTheoric )
    return(bmTheoric)
  }
