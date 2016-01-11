"""
VerseBot for Reddit
By Matthieu Grieger
Continued by Team VerseBot
verse.py
Copyright (c) 2015 Matthieu Grieger (MIT License)
"""

import books
import database
import webparser


class Verse:
    """ Class that holds the properties and methods of a Verse object. """

    def __init__(self, book, chapter, translation, user, subreddit, verse):
        """ Initializes a Verse object with book, chapter, verse (if
        exists), and translation (if exists). """

        self.book = book
        self.subreddit = subreddit.lower()
        book_num = books.get_book_number(self.book)
        if book_num <= 39:
            self.bible_section = "Old Testament"
        elif book_num <= 66:
            self.bible_section = "New Testament"
        else:
            self.bible_section = "Deuterocanon"

        self.chapter = int(chapter.replace(" ", ""))
        if verse != "":
            self.verse = verse.replace(" ", "")
            if "-" in self.verse:
                start_verse, end_verse = self.verse.split("-")
                if end_verse != "" and int(start_verse) > int(end_verse):
                    self.verse = None
                elif end_verse == "" or int(start_verse) == int(end_verse):
                    self.verse = start_verse
                    end_verse = int(start_verse)
                self.start_verse = int(start_verse)
                self.end_verse = int(end_verse)
            else:
                self.start_verse = int(self.verse)
                self.end_verse = self.start_verse
        else:
            self.verse = None
            self.start_verse = 0
            self.end_verse = 0
        if translation != "":
            trans = translation.upper().replace(" ", "")
            if database.is_valid_trans(trans, self.bible_section):
                self.translation = trans
            else:
                self.determine_translation(user, subreddit)
        else:
            self.determine_translation(user, subreddit)

        self.translation_title = ""
        self.contents = ""
        self.permalink = ""

    def determine_translation(self, user, subreddit):
        """ Determines which translation should be used when either the user
        does not provide a translation, or when the user provides an invalid
        translation.

        :param subreddit: The subreddit where the quotation is located
        :param user: The user that called VerseBot for a quotation
        """
        user_default = database.get_user_trans(user, self.bible_section)
        if user_default:
            self.translation = user_default
        else:
            subreddit_default = database.get_subreddit_trans(
                subreddit, self.bible_section)
            if subreddit_default:
                self.translation = subreddit_default
            else:
                if self.bible_section == "Old Testament":
                    self.translation = "ESV"
                elif self.bible_section == "New Testament":
                    self.translation = "ESV"
                else:
                    self.translation = "NRSV"

    def get_contents(self):
        """ Retrieves the contents of a Verse object. """

        self.contents, self.translation_title, self.permalink = \
            webparser.get_web_contents(self)
