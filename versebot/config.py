"""
VerseBot for reddit
By Matthieu Grieger
config.py
Copyright (c) 2015 Matthieu Grieger (MIT License)
"""

from os import environ
from logging import INFO

REDDIT_USERNAME = environ["REDDIT_USERNAME"]
DATABASE_PATH = environ["DATABASE_PATH"]
VERSEBOT_ADMIN = environ["VERSEBOT_ADMIN"]
LOG_LEVEL = INFO
MAXIMUM_MESSAGE_LENGTH = 6000
