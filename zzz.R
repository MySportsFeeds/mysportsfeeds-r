.MySportsFeedsEnv <- new.env()
.MySportsFeedsEnv$data <- list()

.onLoad <- function(libname, pkgname){
  if(is.null(.MySportsFeedsEnv$data) == FALSE){
  	.MySportsFeedsEnv$data <- list(
    	v1_0_username <- NULL,
      v1_0_password <- NULL
    )
  }
}
