# Rocket-Telegram
 Telegram bot for rocket league players.

 Data are extracted from [Rocket League Tracker Network](https://rocketleague.tracker.network) using a webscraper.


## Instructions
On telegram search for the user **@rocket_telegram_bot** or click [this link](http://t.me/rocket_telegram_bot) and start a chat.
Click on the `/start` button.

#### Setting up your player name and plaftorm
To set your name send `/username`
*obs: some players in steam have duplicated names/hard to search, so you can also send your steam id or you custom url*

    /username

To set your plataform send `/platform `, there are 3 platforms available: steam,xbox and ps

    /platform

#### Daily Updates
After starting the chat your account turn on daily updates for statistics and ranked statistics.

To **turn on/off** send `/update`


## Available Commands

###### Account Statistics
Send `/stats` to get available statistics
**Response:**

*Wins: 3,035
Goals: 6,626
Goal/Shot ratio: 48.9
Saves: 4,619
Shots: 13,555
Assists: 2,800
MVPs: 1,310*


###### Ranked Statistics
Send `/rank` to get ranked statistics
*Obs:Only show statistics from playlist where you have rank*
**Response:**

*Playlist: Ranked Doubles 2v2*

  *Rank: Gold III Division II
  Rating: 769
  Division Up: ~3
  Division Down: ~19
  Games: 117*


*Playlist: Ranked Standard 3v3*

  *Rank: Platinum II Division I
  Rating: 890
  Division Up: ~1
  Division Down: ~20
  Games: 59*

###### Registed User
Send `/user` to check which username and platform you registered.
**Response:**
*yourusername,platform*





