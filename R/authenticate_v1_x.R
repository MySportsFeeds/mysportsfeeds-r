#' Authenticate against the MySportsFeeds API (v1.x)
#'
#' Sets the authentication credentials in R environment variables
#'
#' @param apikey.  Your MySportsFeeds API Key
#' @param password.  Your MySportsFeeds account password
#' @examples
#' \dontrun{
#' authenticate_v1_x("<your-api-key>", "<your_account_password>")}
#' @export
#' authenticate_v1_x

authenticate_v1_x <- function(apikey, password){
    if(!is.null(apikey) & !is.null(password)){
        .MySportsFeedsEnv$data$apikey <- apikey
        .MySportsFeedsEnv$data$password <- password
    }
    else{
        warning("You must supply a valid API Key and password to access the MySportsFeeds API (v1.x).")
    }
}
