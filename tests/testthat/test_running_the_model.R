context("Model run")

library(RBGC)

test_that("setupMuso runs",{
        tmpdir <- tempdir()
        copyMusoExampleTo("hhs",tmpdir)
        setwd(tmpdir)
        setupMuso()
        expect_true(TRUE)
})

test_that("spinup runs",
         {
        
        tmpdir <- tempdir()
        copyMusoExampleTo("hhs",tmpdir)
        setwd(tmpdir)
        runBGC(spinupRun=TRUE,normalRun=FALSE)
        expect_true(TRUE)
         }
)

test_that("normal runs",
         {
        tmpdir <- tempdir()
        copyMusoExampleTo("hhs",tmpdir)
        setwd(tmpdir)
        runBGC(spinupRun=FALSE,normalRun=TRUE)
        expect_true(TRUE)
         }
)

