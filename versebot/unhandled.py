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
import sys
from config import *

slackon = False
slackbot = None
slackchannel = None


def start():
    """ Starts the unhandled exception handler and sets up the Slack bot. """

    global slackon
    global slackbot
    global slackchannel
    # Send a message to your Slack channel
    # TODO: Support more channels like Telegram or e-mail
    try:
        from slacky import Slacky
        slackbot = Slacky(token=environ["SLACK_API"])
        try:
            slackchannel = environ["SLACK_CHANNEL"]
        except KeyError:
            logging.warning("No SLACK_CHANNEL environment "
                            "variable set, using #general")
            slackchannel = "#general"
        slackon = True
        sys.excepthook = unhandledexception
    except ImportError:
        logging.warning("slacky required for sending messages "
                        "to your Slack channel when VerseBot fails")
        logging.warning("Use: pip3 install slacky")
    except KeyError:
        logging.warning("No SLACK_API environment variable set")


def send_message():
    """ Send a message to your Slack channel. """

    # TODO: Support more channels like Telegram or e-mail
    if slackon:
        slackbot.chat.post_message(slackchannel, SLACK_MESSAGE, as_user=True)


def unhandledexception(exctype, excvalue, tracebackobj):
    """
    @param exctype exception type
    @param excvalue exception value
    @param tracebackobj traceback object
    """
    tracebackinfo = StringIO()
    # Print the traceback
    traceback.print_tb(tracebackobj, None, tracebackinfo)
    # Print all the variables when the exception happened
    print("\nAll defined variables when the exception happened:\n",
          file=tracebackinfo)
    pprint.pprint(tracebackobj.tb_frame.f_globals, tracebackinfo)
    tracebackinfo.seek(0)

    # Send the gathered information into the logs
    logging.critical(tracebackinfo.read())

    send_message()
    exit(1)
