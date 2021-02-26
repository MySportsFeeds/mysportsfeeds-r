#' Interface with the MySportsFeeds API
#'
#' Return data from the MySportsFeeds API
#'
#' @param version character. The version of the API. Defaults to "1.2".
#' @param league character. The league abbreviation. (e.g. - "nhl", "nfl", "nba", "mlb")
#' @param season character. The applicable season.  (e.g. - "2016-2017-regular")
#' @param feed character. The name of the requested feed.  (e.g. - "player_gamelogs")
#' @param params list. A list that defines additional parameters. Default is empty list.
#' @param verbose logical. For debugging, prints status messages to the console, which can be helpful for walking through results. Default is TRUE.
#'
#' @return a list.
#' @return Response Codes:
#' @return 200: Request was successful
#' @return 204: Feed content not found. There is no available content for the feed as of yet.
#' @return 304: This response code coincides with the optional URL parameter.
#' @return 400: This indicates that some part of the request is malformed.
#' @return 401: Not authenticated.
#' @return 403: Not authorized. You might be trying to access a feed without the correct subscription.
#' @return 429: Too many requests.
#' @return 500: An internal error has occured and has been logged for further inspection. Let us know if you're receiving this response unexpectedly!
#' @return 499,502,503: These usually mean we're in the process of publishing system updates. It should resolve in a matter of a few seconds. If you are seeing this consistently please contact us.
#'
#' @examples
#' \dontrun{
#' authenticate_v1_x("your_username", "your_password")
#' results <- msf_get_results(version = "1.2",
#'                            league = "nhl",
#'                            season = "2016-2017-regular",
#'                            feed = "player_gamelogs",
#'                            params = list()
#'                            verbose = TRUE)
#' }
#' @export
#' msf_get_results

msf_get_results <- function(version="1.2",
                            league,
                            season,
                            feed,
                            params = list(),
                            verbose = FALSE) {

  ## if verbose = TRUE, print status messages
  if (verbose) {
    print("Making API request ...")
  }

  ## make the request
  response <- .make_request(version,
                            .MySportsFeedsEnv$data$apikey,
                            .MySportsFeedsEnv$data$password,
                            league,
                            season,
                            feed,
                            params,
                            verbose=TRUE)

}

.determine_url_v1_x <- function(version,
                                league,
                                season,
                                feed,
                                params) {

  if ( feed == "current_season" ) {
    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/current_season.json", version, league)
  } else {
    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/%s.json", version, league, season, feed)
  }

  return(URL)
}

.determine_url_v2_x <- function(version,
                                league,
                                season,
                                feed,
                                params) {

  if ( feed == "seasonal_games" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/games.json", version, league, season)

  }
  else if ( feed == "daily_games" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["date"]) ) {
      stop("You must specify a 'date' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/date/%s/games.json", version, league, season, params["date"])

  }
  else if ( feed == "weekly_games" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["week"]) ) {
      stop("You must specify a 'week' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/week/%s/games.json", version, league, season, params["week"])

  }
  else if ( feed == "seasonal_dfs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/dfs.json", version, league, season)

  }
  else if ( feed == "daily_dfs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["date"]) ) {
      stop("You must specify a 'date' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/date/%s/dfs.json", version, league, season, params["date"])

  }
  else if ( feed == "weekly_dfs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["week"]) ) {
      stop("You must specify a 'week' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/week/%s/dfs.json", version, league, season, params["week"])

  }
  else if ( feed == "seasonal_player_gamelogs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/player_gamelogs.json", version, league, season)

  }
  else if ( feed == "daily_player_gamelogs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["date"]) ) {
      stop("You must specify a 'date' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/date/%s/player_gamelogs.json", version, league, season, params["date"])

  }
  else if ( feed == "weekly_player_gamelogs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["week"]) ) {
      stop("You must specify a 'week' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/week/%s/player_gamelogs.json", version, league, season, params["week"])

  }
  else if ( feed == "seasonal_team_gamelogs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/team_gamelogs.json", version, league, season)

  }
  else if ( feed == "daily_team_gamelogs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["date"]) ) {
      stop("You must specify a 'date' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/date/%s/team_gamelogs.json", version, league, season, params["date"])

  }
  else if ( feed == "weekly_team_gamelogs" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["week"]) ) {
      stop("You must specify a 'week' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/week/%s/team_gamelogs.json", version, league, season, params["week"])

  }
  else if ( feed == "game_boxscore" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["game"]) ) {
      stop("You must specify a 'game' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/games/%s/boxscore.json", version, league, season, params["game"])

  }
  else if ( feed == "game_playbyplay" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["game"]) ) {
      stop("You must specify a 'game' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/games/%s/playbyplay.json", version, league, season, params["game"])

  }
  else if ( feed == "game_lineup" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["game"]) ) {
      stop("You must specify a 'game' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/games/%s/lineup.json", version, league, season, params["game"])

  }
  else if ( feed == "current_season" ) {

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/current_season.json", version, league)

  }
  else if ( feed == "player_injuries" ) {

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/injuries.json", version, league)

  }
  else if ( feed == "latest_updates" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/latest_updates.json", version, league, season)

  }
  else if ( feed == "seasonal_team_stats" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/team_stats_totals.json", version, league, season)

  }
  else if ( feed == "seasonal_player_stats" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/player_stats_totals.json", version, league, season)

  }
  else if ( feed == "seasonal_venues" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/venues.json", version, league, season)

  }
  else if ( feed == "players" ) {

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/players.json", version, league)

  }
  else if ( feed == "seasonal_standings" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/standings.json", version, league, season)

  }
  else if ( feed == "odds_gamelines" ) {
    if ( is.null(season) ) {
      stop("You must specify a season for this request.");
    }
    if ( is.null(params["date"]) ) {
      stop("You must specify a 'date' param for this request.");
    }

    URL <- sprintf("https://api.mysportsfeeds.com/v%s/pull/%s/%s/date/%s/odds_gamelines.json", version, league, season, params["date"])

  }
  else {
    stop("Unrecognized feed '", feed, "'.");
  }

  return(URL)
}

.make_request <- function(version,
                          apikey,
                          password,
                          league,
                          season,
                          feed,
                          params = list(),
                          verbose = FALSE) {

  ## verify inputs
  stopifnot(is.character(version),
            is.character(apikey),
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
  if ( version == '2.0' | version == '2.1' ) {
    URL <- .determine_url_v2_x(version,
                              league,
                              season,
                              feed,
                              params);
  } else {
    URL <- .determine_url_v1_x(version,
                              league,
                              season,
                              feed,
                              params);
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
              httr::add_headers('Accept-Encoding' = "gzip",
                          'Content-Type' = "application/json"),
              httr::authenticate(apikey, password),
              httr::user_agent(UA),
              query = params)

  ## convert response to text first, do not use baseline httr::content default
  api_response <- httr::content(resp, as="text")

  ## use jsonlite::fromJSON
  tryCatch(
    # This is what I want to do...
    {
      #y = x * 2
      #return(y)
      api_response <- jsonlite::fromJSON(api_response, flatten=TRUE)
    },
    # ... but if an error occurs, tell me what happened:
    error=function(error_message) {
      message("Something went wrong...")
      message(paste("URL Used:", resp[1]))
      message(paste("Response Code Returned:", resp[2]))
      message("Type ?msf_get_results in the console for more info on response codes.")
      return(NA)
    }
  )


  ## if verbose = TRUE, return a list that includes the parsed results
  ## and the original request
  if (verbose) {
    api_response <- list(response = resp,
                         api_json = api_response)
  }

  ## return the data
  return(api_response)
}
