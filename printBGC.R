#' print.BGC 
#'
#' This is the default printing method for the BGC object
#' 
#' @author Roland HOLL\'{O}S
#' @param settings RBBGCMuso uses variables that define the entire simulation environment. Those environment variables include the name of the INI files, the name of the meteorology files, the path to the model executable and its file name, the entire output list, the entire output variable matrix, the dependency rules for the EPC parameters etc. Using the runMuso function RBBGCMuso can automatically create those environment variables by inspecting the files in the working directory (this happens through the setupMuso function). It means that by default model setup is performed automatically in the background and the user has nothing to do. With this settings parameter we can force runMuso to skip automatic environment setup as we provide the environment settings to runMuso. In a typical situation the user can skip this option.
#' @param runType you can run the modell in a spinup, normal, or a complete mode. Normal is the default. 
#' @param inputParams The index of the input values.
#' @return No return, outputs are written to file, if it's soil parameter, pleas provide
#' @usage calibMuso(settings,parameters=NULL, timee='d', debugging=FALSE, logfilename=NULL,
#' keepEpc=FALSE, export=FALSE, silent=FALSE, aggressive=FALSE, leapYear=FALSE)
#' @import utils
#' @importFrom future future
#' @importFrom promises %...>%
#' @importFrom lubridate leap_year day month
#' @export

print.BGC <- function(x){
    cat(sprintf("The number of variables is: %s\n", ncol(x)))
    cat(sprintf("The number of days is: %s\n", nrow(x)))
    print(summary(x))
}
