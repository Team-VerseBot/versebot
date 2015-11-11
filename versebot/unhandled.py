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
from os import environ

# Send a message to your Slack channel
# TODO: Support more channels like Telegram or e-mail
slackon = False
try:
    from slacky import Slacky
    bot = Slacky(token=environ['SLACK_API'])
    slackon = True
    # The Team Versebot's bot is called St. Gabriel the Archangel, so this
    # message makes sense. Customize it as you see fit for your own bot if you
    # are running your own instance of Versebot.
    message = ("I am Gabriel. I stand in the presence of God, and I have been "
               "sent to speak to you and to bring you this good news:"
               " Versebot is down because an unhandled exception")
except ImportError:
    logging.warn("slacky required for sending messages "
                 "to your slack channel when versebot fails")
    logging.warn("Use: pip3 install slacky")
except IndexError:
    logging.warn("No SLACK_API environment variable set")


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
    print("\nAll defined variables when the exception happened:\n",
          file=tracebackinfo)
    pprint.pprint(tracebackobj.tb_frame.f_globals, tracebackinfo)
    tracebackinfo.seek(0)

    # Send the gathered information into the logs
    logging.critical(tracebackinfo.read())

    if slackon:
        bot.chat.post_message("#development", message, as_user=True)

    exit(1)
