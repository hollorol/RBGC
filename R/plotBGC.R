#' plot.BGC 
#'
#' This function makes possible to use the build in plotting engine in R on BGC opjects
#' 
#' @author Roland HOLLÓS
#' @param modelInput The BGC object variable
#' @param variable which variable you want to plot
#' @export


plot.BGC <- function(modelInput=NULL,variable=NULL,...){
    modelInput <- runBGC()
    if(missing(variable))
    plot(x=modelInput[,1], y=modelInput[,3],...)
}
