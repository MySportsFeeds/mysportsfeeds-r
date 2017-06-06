#' Authenticate against the MySportsFeeds API (v1.0)
#'
#' Sets the authentication credentials in R environment variables
#'
#' @param username.  Your MySportsFeeds account username
#' @param password.  Your MySportsFeeds account password
#' @examples
#' \dontrun{
#' authenticate_v1_0("your-username", "your_password")}
#' @export
#' authenticate_v1_0

authenticate_v1_0 <- function(username, password){
    if(!is.null(username) & !is.null(password)){
        .MySportsFeedsEnv$data$username <- username
        .MySportsFeedsEnv$data$password <- password
    }
    else{
        warning("You must supply a valid username/password to access the MySportsFeeds API (v1.0).")
    }
}
