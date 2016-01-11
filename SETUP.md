VerseBot Setup
==============

## Dependencies ##
### Required ###
* [Python 3](https://www.python.org/downloads/) -- Self explanatory.
* [pip](https://pypi.python.org/pypi/pip) -- Tool that allows easy installation of Python modules.
* [BeautifulSoup](http://www.crummy.com/software/BeautifulSoup/) -- Web parser for parsing BibleGateway.
* [PRAW](https://github.com/praw-dev/praw) -- Python Reddit API Wrapper.
* [praw-OAuth2Util](https://github.com/SmBe19/praw-OAuth2Util) -- Allows for easy OAuth authentication with PRAW.
* [psycopg2](http://initd.org/psycopg/) -- PostgreSQL driver for Python.
* [PostgreSQL](http://www.postgresql.org/) -- Relational database used by VerseBot for storing statistics.

### Optional ###
* [pyenv](https://github.com/yyuu/pyenv) -- Really helpful tool for managing separate python versions and virtual environments.
* [Slacky](https://github.com/nabetama/slacky/) -- A Python package for Slack's JSON REST API. Used for sending messages to your slack channel when your instance of Versebot is down because an unhandled exception. Create a bot for [your Slack](https://my.slack.com/services/new/bot) and set the environment variable `SLACK_API` with the bot's API token. Set `SLACK_CHANNEL`, otherwise messages will be sent to `#general` channel.

## Setup ##
1. Clone the VerseBot repository via `git`.
2. Setup a PostgreSQL database for VerseBot. [This guide explains the process fairly well.](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-postgresql-on-ubuntu-14-04)
3. Execute the SQL files found within the sql directory. The order in which they are executed shouldn't matter if I remember correctly. Ignore the files within the update_old_db directory.
4. Edit the relevant configuration values within `config.py`. At the moment they are specified as environment variables to avoid accidentally committing passwords and database URLs. [See here for advice on how to setup environment variables.](http://unix.stackexchange.com/questions/117467/how-to-permanently-set-environmental-variables) The database URL is a URL to the PostgreSQL database, which is how VerseBot connects to the database. [See this link for instructions on how to create a database URL.](http://stackoverflow.com/questions/3582552/postgres-connection-url)
5. Start the bot and make sure everything works. The bot should automatically populate the translation table with the translations available on BibleGateway.

If everything works, this should be it for setup!

## Recommendations ##
* Daemonizing VerseBot would be a good idea. It can be done using something like [`python-daemon`](https://github.com/serverdensity/python-daemon), or by wrapping VerseBot in something like [upstart in Ubuntu](https://www.digitalocean.com/community/tutorials/the-upstart-event-system-what-it-is-and-how-to-use-it).
* It may be worth migrating the database to SQLite or something similar to make things simpler. The use of PostgreSQL was a forced decision as VerseBot was first run on Heroku which requires the usage of a PostgreSQL database. The SQL would need to be edited as the current SQL is specific to PostgreSQL (namely the timestamp update trigger).
