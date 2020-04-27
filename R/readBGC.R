#' readBGC 
#'
#' This function reads the model's output file in a well-structured way. As the result is passed to R, the results can be easily post-processed in R environment. 
#' 
#' @author Roland HOLLÓS
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

readBGC <- function(settings, spinup = FALSE, simplified = FALSE) {
    if (!spinup) {
        dayoutFile <- paste0(file.path(settings$outputLoc, settings$outputNames[2]), 
            ".dayout")
    } else {
        dayoutFile <- paste0(file.path(settings$outputLoc, settings$outputNames[1]), 
            ".dayout")
    }
    dayoutFileConn <- file(dayoutFile, "rb")
    dayoutput <- matrix(readBin(dayoutFileConn, "double", size = 8, n = (settings$numData[1])), 
        (settings$numYears * 365), byrow = TRUE)
    close(dayoutFileConn)
    dates <- seq(from = as.Date(paste0(settings$startYear, "-01-01")), to = as.Date(paste0(settings$startYear + 
        settings$numYears - 1, "-12-31")), by = "day")
    dates <- dates[!(leap_year(as.Date(dates)) & (month(as.Date(dates)) == 2) & 
        (day(as.Date(dates)) == 29))]
    dayoutput <- cbind.data.frame(dates, dayoutput)
    colnames(dayoutput) <- c("dateB", settings$outputVars[[1]])
    if (!simplified) {
        class(dayoutput) <- c("BGC", class(dayoutput))
    }
    return(dayoutput)
}
