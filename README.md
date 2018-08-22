# mysportsfeeds-r

MySportsFeeds R Wrapper brought to you by [@MySportsFeeds](https://twitter.com/MySportsFeeds).

Makes use of the [MySportsFeeds API](https://www.mysportsfeeds.com) - a flexible, developer-friendly Sports Data API.

Free for Non-Commercial Use.

##Install

`devtools::install_github("MySportsFeeds/mysportsfeeds-r")`

##Usage

If you haven't signed up for API access, do so here [https://www.mysportsfeeds.com](https://www.mysportsfeeds.com/index.php/register/)

To authenticate (v1.x):

```
library(mysportsfeedsR)
authenticate_v1_x('<your-api-key>', '<your-account-password>')
```

To authenticate (v2.0): This will assume the expected v2.0 password of "MYSPORTSFEEDS"

```
library(mysportsfeedsR)
authenticate_v2_x('<your-api-key>')
```

Start making requests, specifying: league, season, feed, format, and any other applicable params for the feed


Example (v1.x): Get all NBA 2016-2017 regular season gamelogs for Stephen Curry, in JSON format

```
gamelogs <- msf_get_results(version='1.2',league='nba',season='2016-2017-regular',feed='player_gamelogs',params=list(player='stephen-curry'))
```

Example (v1.x): Get all NFL 2015 regular season seasonal stats totals for all Dallas Cowboys players, in XML format

```
season_stats <- msf_get_results(version='1.2',league='nfl',season='2015-regular',feed='cumulative_player_stats',params=list(team='dallas-cowboys'))
```

Example (v1.x): Get full game schedule for the MLB 2016 playoff season, in CSV format

```
full_sched <- msf_get_results(version='1.2',league='mlb',season='2016-playoff',feed='full_game_schedule')
```

Example (v2.0): Get all NBA 2016-2017 regular season gamelogs for Stephen Curry, in JSON format

```
gamelogs <- msf_get_results(version='2.0',league='nba',season='2016-2017-regular',feed='seasonal_player_gamelogs',params=list(player='stephen-curry'))
```

Example (v2.0): Get all NFL 2015 regular season seasonal stats totals for all Dallas Cowboys players, in XML format

```
season_stats <- msf_get_results(version='2.0',league='nfl',season='2015-regular',feed='seasonal_player_stats',params=list(team='dallas-cowboys'))
```

Example (v2.0): Get full game schedule and scores for the MLB 2016 playoff season, in CSV format

```
full_sched <- msf_get_results(version='2.0',league='mlb',season='2016-playoff',feed='seasonal_games')
```

That's it!  Enjoy all the data you can eat!
