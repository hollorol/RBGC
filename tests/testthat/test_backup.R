context("Test backup")

library(RBGC)

test_that("backup files",
          {

              tmpdir <- tempdir()
              copyMusoExampleTo("hhs",tmpdir)
              iniFiles <- list.files(pattern=".*ini")
              backupBGC(setupMuso(),iniFiles)
              expect_equal(iniFiles,list.files(pattern=".*ini","bck"))
          }
)

test_that("restore files",
          {
              #
              # tmpdir <- tempdir()
              # copyMusoExampleTo("hhs",tmpdir)
              # iniFiles <- list.files(pattern="*.ini")
              # sapply(iniFiles,file.remove)
              # backupBGC()
              # expect_equal(iniFiles,list.files(pattern=".*ini"))
              warning("Automatic revert is not finished")
          }
)
