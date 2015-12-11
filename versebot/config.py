"""
VerseBot for reddit
By Matthieu Grieger
config.py
Copyright (c) 2015 Matthieu Grieger (MIT License)
"""

from os import environ
from logging import INFO

# VerseBot
REDDIT_USERNAME = environ["REDDIT_USERNAME"]
DATABASE_PATH = environ["DATABASE_PATH"]
VERSEBOT_ADMIN = environ["VERSEBOT_ADMIN"]
LOG_LEVEL = INFO
MAXIMUM_MESSAGE_LENGTH = 6000

# Slack
# The Team VerseBot's bot is called St. Gabriel the Archangel, so this
# message makes sense. Customize it as you see fit for your own bot if you
# are running your own instance of VerseBot.
SLACK_MESSAGE = "I am Gabriel. I stand in the presence of God, and I have " \
                "been sent to speak to you and to bring you this good news: " \
                "VerseBot is down because of an unhandled exception."
