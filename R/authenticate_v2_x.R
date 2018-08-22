#' Authenticate against the MySportsFeeds API (v2.x)
#'
#' Sets the authentication credentials in R environment variables
#'
#' @param apikey.  Your MySportsFeeds API Key
#' @examples
#' \dontrun{
#' authenticate_v2_x("<your-api-key>")}
#' @export
#' authenticate_v2_x

authenticate_v2_x <- function(apikey){
    if(!is.null(apikey)){
        .MySportsFeedsEnv$data$apikey <- apikey
        .MySportsFeedsEnv$data$password <- 'MYSPORTSFEEDS'
    }
    else{
        warning("You must supply a valid API Key to access the MySportsFeeds API (v2.x).")
    }
}
