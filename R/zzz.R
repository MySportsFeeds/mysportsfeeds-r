.onLoad <- function(libname, pkgname){
  .MySportsFeedsEnv <<- new.env()

  .MySportsFeedsEnv$data <- list(
    apikey <- NULL,
    password <- NULL
  )
}
