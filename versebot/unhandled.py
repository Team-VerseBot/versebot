"""
VerseBot for reddit
By Matthieu Grieger
unhandled.py
Copyright (c) 2015 Matthieu Grieger (MIT License)
"""

import logging
import traceback
import pprint
from io import StringIO


def unhandledexception(excType, excValue, tracebackobj):
    """
    @param excType exception type
    @param excValue exception value
    @param tracebackobj traceback object
    """
    tracebackinfo = StringIO()
    # Print the traceback
    traceback.print_tb(tracebackobj, None, tracebackinfo)
    # Print all the variables when the exception happened
    pprint.pprint(locals(), tracebackinfo)
    tracebackinfo.seek(0)

    # Send the gathered information into the logs
    logging.critical(tracebackinfo.read())
    # TODO: Send a message to people in the Team Versebot's Slack channel so
    # the bot can be restarted soon as possible.

    exit(1)
