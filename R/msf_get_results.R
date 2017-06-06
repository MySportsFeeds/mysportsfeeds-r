#' Interface with the MySportsFeeds API
#'
#' Return data from the MySportsFeeds API
#'
#' @param version character. The version of the API. Defaults to "1.0".
#' @param league character. The league abbreviation. (e.g. - "nhl", "nfl", "nba", "mlb")
#' @param season character. The applicable season.  (e.g. - "2016-2017-regular")
#' @param feed character. The name of the requested feed.  (e.g. - "player_gamelogs")
#' @param params list. A list that defines additional parameters. Default is empty list.
#' @param verbose logical. For debugging, prints status messages to the console, which can be helpful for walking through results. Default is TRUE.
#'
#' @return a list.
#'
#' @examples
#' \dontrun{
#' authenticate_v1_0("your_username", "your_password")
#' results <- msf_get_results(version = "1.0",
#'                            league = "nhl",
#'                            season = "2016-2017-regular",
#'                            feed = "player_gamelogs",
#'                            params = list()
#'                            verbose = TRUE)
#' }
#' @export
#' msf_get_results

msf_get_results <- function(version="1.0",
                            league,
                            season,
                            feed,
                            params = list(),
                            verbose = FALSE) {

  ## if verbose = TRUE, print status messages
  if (verbose) {
    print("Making API request ...")
  }

  ## make the request (v1.0)
  response <- .make_request_v1_0(.MySportsFeedsEnv$data$username, .MySportsFeedsEnv$data$password,
    league, season, feed, params, verbose=TRUE)

}

.make_request_v1_0 <- function(username,
                               password,
                               league,
                               season,
                               feed,
                               params = list(),
                               verbose = FALSE) {

  ## verify inputs
  stopifnot(is.character(username),
            is.character(password),
            is.character(league),
            is.character(feed),
            is.list(params),
            is.logical(verbose),
            length(league) == 1,
            length(feed) == 1)
  if ( feed != "current_season" ) {
    stopifnot(is.character(season),
              length(season) == 1)
  }

  ## use lower case
  league = tolower(league)
  season = tolower(season)
  feed = tolower(feed)

  ## build the URL
  if ( feed == "current_season" ) {
    URL <- sprintf("https://www.mysportsfeeds.com/api/feed/pull/%s/current_season.json")
  } else {
    URL <- sprintf("https://www.mysportsfeeds.com/api/feed/pull/%s/%s/%s.json", league, season, feed)
  }
  if (verbose) {
    print(sprintf("URL = '%s'", URL))
  }

  ## if page is supplied, add it to the list
  #if (!is.na(page) & is.numeric(page) & page >= 1) {
  #  query <- c(query, page=page)
  #}

  ## info for the User-Agent header
  platform <- sessionInfo()$platform
  package_v <- packageVersion("mysportsfeedsR")
  UA <- sprintf("MySportsFeeds-R/%s (%s)", package_v, platform)

  resp <- httr::GET(URL,
              add_headers('Accept-Encoding' = "gzip",
                          'Content-Type' = "application/json"),
              authenticate(username, password),
              user_agent(UA),
              query = params)

  ## convert response to text first, do not use baseline httr::content default
  api_response <- content(resp, as="text")

  ## use jsonlite::fromJSON
  api_response <- jsonlite::fromJSON(api_response, flatten=TRUE)

  ## if verbose = TRUE, return a list that includes the parsed results
  ## and the original request
  if (verbose) {
    api_response <- list(response =  resp,
                         api_json = api_response)
  }

  ## return the data
  return(api_response)
}
