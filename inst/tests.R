#Copy muso example to
copyMusoExampleTo("hhs","~/bgTrial/")
#Test file-changer

parameters <- data.frame(inputParams=c(128.2),
                         paramValues=c(77),
                         inputFiles=c("c3grass_muso6.epc"),
                         stringsAsFactors=FALSE)


changeInputs(setupMuso(),parameters)

parameters2 <- data.frame(inputParams=c(128.3),
                         paramValues=c(88),
                         inputFiles=c("c3grass_muso6.epc"),
                         stringsAsFactors=FALSE)

changeInputs(setupMuso(),parameters2)
traceback()
