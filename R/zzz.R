.onLoad <- function(libname, pkgname){
  .MySportsFeedsEnv <<- new.env()

  .MySportsFeedsEnv$data <- list(
    v1_0_username <- NULL,
    v1_0_password <- NULL
  )
}
