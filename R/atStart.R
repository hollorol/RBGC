.onLoad <- function(libname,pkgname){
    packVersion <- installed.packages()["RBGC","Version"]
    cat(sprintf("This is RBC version %s\n",packVersion))
    RMuso_version <- 6 
    RMuso_constMatrix <- list(epc=NULL,soil=NULL) 
    RMuso_varTable <- list()
    #___________________________
    sapply(names(RMuso_constMatrix),function(fType){
        sapply(list.files(path=system.file("data",package="RBGC"),
                          pattern=sprintf("^%sConstMatrix\\d\\.json$",fType), full.names=TRUE),function(fName){
            constMatrix <- jsonlite::read_json(fName,simplifyVector = TRUE)[,c(1,2,3,4,9,5,6,7,8)]
            version <- gsub(".*(\\d)\\.json","\\1",fName)
            RMuso_constMatrix[[fType]][[version]] <<- constMatrix
        })
        RMuso_constMatrix
        # RMuso_constMatrix <<- RMuso_constMatrix 
    })


        sapply(list.files(path=system.file("data",package="RBGC"),
                          pattern="^varTable\\d\\.json$", full.names=TRUE),function(fName){
            varTable <- jsonlite::read_json(fName,simplifyVector = TRUE)
            version <- gsub(".*(\\d)\\.json","\\1",fName)
            RMuso_varTable[[version]] <<- varTable
        })
    errorCodes <- new.env()
    errors <- read.csv(file.path(system.file("data",package="RBGC"), "error_flags.csv"),
                           stringsAsFactors=FALSE)
    Map(function(x,y){assign(as.character(x),y,envir=errorCodes)},errors[,1],errors[,2])
    
    options(RMuso_version = RMuso_version,
            RMuso_constMatrix = RMuso_constMatrix,
            RMuso_varTable = RMuso_varTable,
            RMuso_errorCodes = errorCodes)
}
