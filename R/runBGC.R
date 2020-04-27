#' runBGC 
#'
#' This function runs the Biome-BGCMuSo model (with option to change the EPC file), then it reads its output file in a well-structured way. As the result is passed to R, the results can be easily post-processed in R environment. 
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
#' @export

runBGC <- function(settings = NULL, spinupRun=FALSE, normalRun=TRUE, runType = NULL, parameters = NULL, silent = TRUE, 
    export = FALSE, backup = TRUE, simplified = FALSE, expectOutput = FALSE) {
    
    if (missing(settings)) {
        settings <- setupMuso()
    }
    
    if(!any(spinupRun,normalRun)){
        stop("You should choose spinup or normal run")
    }

    if (!missing(parameters)) {
        changeInputs(settings, parameters, backup)
    }

    silent <- ifelse(silent, FALSE, "")

    if((spinupRun)==TRUE){ # It is safer than using simply spinupRun boolean. The reason is implicit type inference ... :(
        future({
            setwd(settings$inputLoc)
            status <- system2(settings$executable, settings$iniInput[1], stdout = silent)
            status
        }) %...>% '<<-'(status,.)
        
        if (status != 0) {
            stop("Model Error, or invalid input files, spinup run FAILED")
        }

        if(expectOutput==TRUE){
            readBGC(settings,spinup=TRUE, simplified=simplified)
        }
    }
   
    if((normalRun) == TRUE) {
        future({
            setwd(settings$inputLoc)
            status <- system2(settings$executable, settings$iniInput[2], stdout = silent)
            status
        }) %...>% '<<-'(status,.)
        
        if (status != 0) {
            stop("Model Error, or invalid input files, normal run FAILED, did you run spinup? If not, set spinupRun=TRUE")
        }

        readBGC(settings,spinup=FALSE, simplified=simplified)

    } 
}
