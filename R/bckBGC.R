#' backupBGC
#'
#' backupBGC is a function for back up files which will be modified
#' @param settings RBBGCMuso uses variables that define the entire simulation environment. Those environment variables include the name of the INI files, the name of the meteorology files, the path to the model executable and its file name, the entire output list, the entire output variable matrix, the dependency rules for the EPC parameters etc. Using the runMuso function RBBGCMuso can automatically create those environment variables by inspecting the files in the working directory (this happens through the setupMuso function). It means that by default model setup is performed automatically in the background and the user has nothing to do. With this settings parameter we can force runMuso to skip automatic environment setup as we provide the environment settings to runMuso. In a typical situation the user can skip this option.
#' @param files filesTobackup
#' @export
backupBGC <- function(settings=NULL, files=NULL, bckDir = NULL) {

    # if(missing(settings) && ){
    #     inputLoc <- setupMuso()$inputLoc
    # }

    if(!missing(files)){
        # filePaths <- file.path(settings$inputLoc,files)
        # writeLines(filePaths,file.path(settings$bck_dir,"sources.bck"))
        sapply(files,function(inputFile){file.copy(from = file.path(settings$inputLoc,inputFile), to = file.path(settings$bck_dir, 
                                                                                            inputFile),overwrite=FALSE)})
    } else{
        stop("Automatic reverting is not supported yet")
        # destinations <- readLines(file.path(settings$bck_dir,"sources.bck"))
        # sapply(list.files(settings$bck_dir),function(x){
        #     index <- grep(file.path(settings$inputLoc,x),destinations,fixed=TRUE)
        #     if(length(index)==1){
        #         file.copy(file.path(settings,bck_dir),destination[index])
        #     }
        # })
    }
}
