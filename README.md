# mysportsfeeds-r

MySportsFeeds R Wrapper brought to you by [@MySportsFeeds](https://twitter.com/MySportsFeeds).

Makes use of the [MySportsFeeds API](https://www.mysportsfeeds.com) - a flexible, developer-friendly Sports Data API.

Free for Non-Commercial Use.

##Install

`devtools::install_github("MySportsFeeds/mysportsfeeds-r")`

##Usage

If you haven't signed up for API access, do so here [https://www.mysportsfeeds.com/index.php/register/](https://www.mysportsfeeds.com/index.php/register/)

```
library(mysportsfeedsR)
authenticate_v1_0('your-username', 'your-password')
```

Start making requests, specifying: league, season, feed, format, and any other applicable params for the feed

Get all NBA 2016-2017 regular season gamelogs for Stephen Curry, in JSON format

```
gamelogs <- msf_get_results(league='nba',season='2016-2017-regular',feed='player_gamelogs',params=list(player='stephen-curry'))
```

Get all NFL 2015-2016 regular season seasonal stats totals for all Dallas Cowboys players, in XML format

```
season_stats <- msf_get_results(league='nfl',season='2015-2016-regular',feed='cumulative_player_stats',params=list(team='dallas-cowboys'))
```

Get full game schedule for the MLB 2016 playoff season, in CSV format

```
full_sched <- msf_get_results(league='mlb',season='2016-playoff',feed='full_game_schedule')
```

That's it!  Enjoy all the data you can eat!
