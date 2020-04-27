#' changeInputs 
#'
#' This function is for changeing inputs
#' 
#' @author Roland HOLLÓS
#' @param settings RBBGCMuso uses variables that define the entire simulation environment. Those environment variables include the name of the INI files, the name of the meteorology files, the path to the model executable and its file name, the entire output list, the entire output variable matrix, the dependency rules for the EPC parameters etc. Using the runMuso function RBBGCMuso can automatically create those environment variables by inspecting the files in the working directory (this happens through the setupMuso function). It means that by default model setup is performed automatically in the background and the user has nothing to do. With this settings parameter we can force runMuso to skip automatic environment setup as we provide the environment settings to runMuso. In a typical situation the user can skip this option.
#' @param parameters Parameter matrix with column names=c("inputParams","paramValues","inputFiles")
#' @param inputParams The index of the input values.
#' @return No return, outputs are written to file, if it's soil parameter, pleas provide
#' @export

changeInputs <- function(settings, parameters, backup = TRUE) {
    changeNth <- function (string,place,replacement) {
        gsub(sprintf("^((.*?\\s+){%s})(.*?\\s+)", place), sprintf("\\1%s ", replacement), string, perl=TRUE)
    }

    changeSingle <- function (rowIndex, parameter, matName){
        h <- round((rowIndex*100) %% 100) %/% 10
        i <- as.integer(rowIndex)
        changeNth(matName[i], h, parameter)        
    }
    parameters <- as.data.frame(parameters)
    if(nrow(parameters)>1){
        inputList <- split(as.data.frame(parameters), parameters$inputFiles)
    } else {
        inputList <- list()
        inputList[[parameters[,"inputFiles"]]] <- parameters[,-ncol(parameters)]
    }
    if(backup){
        tryCatch(backupBGC(settings, parameters$inputFiles), error = function(e) {
                  stop(sprintf("The backup directory %s is invalid or input file specification is not correct", 
                               settings$bck_dir))
         })
    }

    inputFiles <- lapply(names(inputList),function(x){
               readLines(x)
         })

    names(inputFiles) <- names(inputList)
    
    sapply(names(inputList),function(inputFile){
              parTable <- inputList[[inputFile]]
              Map(function(x,y){
                      inputFiles[[inputFile]][as.integer(x)] <<- changeSingle(x,y,inputFiles[[inputFile]])
              }, parTable$inputParams, parTable$paramValues)
              writeLines(inputFiles[[inputFile]],inputFile)
         })
}
