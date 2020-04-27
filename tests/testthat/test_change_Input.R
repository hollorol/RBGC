context("change Input")

library(RBGC)

test_that("Copy files",
         {
        
        filenames <- c("c3grass_muso6.epc","CO2.txt","compile_log_linux.txt",
                       "cygwin1.dll","hhs.mgm","hhs.mow","hhs.mtc43","hhs.soi",
                       "HU-He2_2012_MEASURED.txt","muso","muso.exe","n.ini",
                       "Ndep.txt","parameters.csv","s.ini")
        filenames <- grep("(exe|dll)$",filenames,invert=TRUE, value=TRUE) 
             expect_equal(prod(sapply(filenames,function(x) is.element(x,list.files(tmpdir)))),1)
         }
)
