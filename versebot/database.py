"""
VerseBot for Reddit
By Matthieu Grieger
Continued By Team VerseBot
database.py
Copyright (c) 2015 Matthieu Grieger (MIT License)
"""

import sqlite3

from config import DATABASE_PATH
from regex import find_already_quoted_verses

_conn = None
cur = None


def connect(logger):
    """ Connect to SQLite database.

    :param logger: The logger used in the instance of VerseBot
    """
    global _conn
    global cur
    try:
        _conn = sqlite3.connect(DATABASE_PATH)
        cur = _conn.cursor()
    except sqlite3.Error:
        logger.critical("Connection to database failed. Exiting...")
        exit(1)


def update_book_stats(new_books, is_edit_or_delete=False):
    """ Updates book_stats table with recently quoted books.
    Alternatively, this function is also used to remove book counts
    that were added by a comment that has been edited/deleted.

    :param is_edit_or_delete: Whether a comment has been edited or deleted
    :param new_books: Recently quoted books
    """
    for book in new_books.items():
        if is_edit_or_delete:
            cur.execute("UPDATE book_stats SET t_count = t_count - %d "
                        "WHERE book = '%s'" % (book[1], book[0]))
        else:
            cur.execute("UPDATE book_stats SET t_count = t_count + %d "
                        "WHERE book = '%s'" % (book[1], book[0]))
    _conn.commit()


def update_subreddit_stats(new_subreddits, is_edit_or_delete=False):
    """ Updates subreddit_stats table with subreddits that have recently used
    VerseBot. Alternatively, this function is also used to remove subreddit
    counts that were added by a comment that has been edited/deleted.

    :param is_edit_or_delete: Whether a comment has been edited or deleted
    :param new_subreddits: Subreddits that have recently used VerseBot
    """
    for subreddit in new_subreddits.items():
        if is_edit_or_delete:
            cur.execute("UPDATE subreddit_stats SET t_count = t_count - %d "
                        "WHERE sub = '%s';" % (subreddit[1], subreddit[0]))
            cur.execute("DELETE FROM subreddit_stats WHERE t_count = 0;")
        else:
            cur.execute("UPDATE subreddit_stats SET t_count = t_count + %d "
                        "WHERE sub = '%s';" % (subreddit[1], subreddit[0]))
            cur.execute("INSERT INTO subreddit_stats (sub, t_count) "
                        "SELECT '%(subreddit)s', %(num)s WHERE NOT EXISTS "
                        "(SELECT 1 FROM subreddit_stats "
                        "WHERE sub = '%(subreddit)s');"
                        % {"subreddit": subreddit[0], "num": subreddit[1]})
    _conn.commit()


def update_trans_stats(translations, is_edit_or_delete=False):
    """ Updates translation_stats table with recently used translations.
    Alternatively, this function is also used to remove translation counts
    that were added by a comment that has been edited/deleted.

    :param is_edit_or_delete: Whether a comment has been edited or deleted
    :param translations: Recently used translations
    """
    for translation in translations.items():
        trans = translation[0]
        count = translation[1]
        if is_edit_or_delete:
            cur.execute("UPDATE translation_stats SET t_count = t_count - %d "
                        "WHERE trans = '%s'" % (count, trans))
        else:
            cur.execute("UPDATE translation_stats SET t_count = t_count + %d "
                        "WHERE trans = '%s'" % (count, trans))
    _conn.commit()


def prepare_trans_list_update():
    """ Prepares the translation_stats table for a translation list update.
    For all translations, available is set to false. The translations that are
    currently available will later be set to true. """

    cur.execute("UPDATE translation_stats SET available = 0;")
    _conn.commit()


def update_trans_list(translations):
    """ Updates translation_stats table with new translations that have been
    added. This query will also reset the available column for ALL
    translations to false, and then reset them to true individually if the
    translation exists in the local list of translations. This prevents users
    from trying to use translations within the database that are not
    officially supported anymore.

    :param translations: Available translations
    """
    prepare_trans_list_update()
    for trans in translations:
        cur.execute("UPDATE translation_stats SET available = 1 "
                    "WHERE trans = '%s';" % trans.abbreviation)
        cur.execute("INSERT INTO translation_stats "
                    "(trans, name, lang, has_ot, has_nt, has_deut, available) "
                    "SELECT '%(tran)s', '%(tname)s', '%(language)s', "
                    "%(ot)s, %(nt)s, %(deut)s, 1 WHERE NOT EXISTS "
                    "(SELECT 1 FROM translation_stats "
                    "WHERE trans = '%(tran)s');"
                    % {"tran": trans.abbreviation,
                       "tname": trans.name.replace("'", "''"),
                       "language": trans.language, "ot": int(trans.has_ot),
                       "nt": int(trans.has_nt), "deut": int(trans.has_deut)})
    _conn.commit()


def update_user_trans(username, ot_trans, nt_trans, deut_trans):
    """ Updates user_translation table with new custom default translations
    specified by the user.

    :param deut_trans: Requested Deuterocanon translation
    :param nt_trans: Requested New Testament translation
    :param ot_trans: Requested Old Testament translation
    :param username: Username of the user who requested the update
    """
    cur.execute("UPDATE user_translations "
                "SET ot_default = '%s', nt_default = '%s', "
                "deut_default = '%s', last_used = datetime('now') "
                "WHERE username = '%s';"
                % (ot_trans, nt_trans, deut_trans, username))
    cur.execute("INSERT INTO user_translations "
                "(username, ot_default, nt_default, deut_default) "
                "SELECT '%(name)s', '%(ot)s', '%(nt)s', '%(deut)s' "
                "WHERE NOT EXISTS (SELECT 1 FROM user_translations "
                "WHERE username = '%(name)s');"
                % {"name": username, "ot": ot_trans,
                   "nt": nt_trans, "deut": deut_trans})
    _conn.commit()


def get_user_trans(username, bible_section):
    """ Retrieves the default translation for the user in a certain section
    of the Bible.

    :param bible_section: Old Testament, New Testament, or Deuterocanon
    :param username: Username of the user who called VerseBot
    """
    if bible_section == "Old Testament":
        section = "ot_default"
    elif bible_section == "New Testament":
        section = "nt_default"
    else:
        section = "deut_default"
    cur.execute("SELECT %s FROM user_translations WHERE username = '%s';"
                % (section, str(username)))
    try:
        trans = cur.fetchone()[0]
    except TypeError:
        trans = None
    cur.execute("UPDATE user_translations SET last_used = datetime('now') "
                "WHERE username = '%s'" % str(username))
    _conn.commit()
    return trans


def clean_user_trans():
    """ Removes user translation entries that haven't been used for 90 days
    or more to save on database space. """

    cur.execute("DELETE FROM user_translations "
                "WHERE last_used < datetime('now', '-90 days');")
    _conn.commit()


def update_subreddit_trans(subreddit, ot_trans, nt_trans, deut_trans):
    """ Updates subreddit_translation table with new custom default
    translations specified by a moderator of a subreddit.

    :param deut_trans: Requested Deuterocanon translation
    :param nt_trans: Requested New Testament translation
    :param ot_trans: Requested Old Testament translation
    :param subreddit: Subreddit that requested a translation update
    """
    cur.execute("INSERT INTO subreddit_translations "
                "(sub, ot_default, nt_default, deut_default) "
                "SELECT '%(subreddit)s', '%(ot)s', '%(nt)s', '%(deut)s' "
                "WHERE NOT EXISTS (SELECT 1 FROM subreddit_translations "
                "WHERE sub = '%(subreddit)s');"
                % {"subreddit": subreddit.lower(), "ot": ot_trans,
                   "nt": nt_trans, "deut": deut_trans})
    _conn.commit()


def get_subreddit_trans(subreddit, bible_section):
    """ Retrieves the default translation for the subreddit in a certain
    section of the Bible.

    :param bible_section: Old Testament, New Testament, or Deuterocanon
    :param subreddit: The subreddit that called VerseBot
    """
    if bible_section == "Old Testament":
        section = "ot_default"
    elif bible_section == "New Testament":
        section = "nt_default"
    else:
        section = "deut_default"
    cur.execute("SELECT %s FROM subreddit_translations WHERE sub = '%s';"
                % (section, subreddit.lower()))
    try:
        trans = cur.fetchone()[0]
        return trans
    except TypeError:
        return None


def is_valid_trans(trans, testament):
    """ Checks the translations table for the supplied translation, and
    determines whether it is valid for the book that the user wants to quote.
    If the translation is not valid (either it is not available, or it doesn't
    contain the book), the translation will either default to the subreddit
    default or the global default.

    :param testament: Old Testament, New Testament, or Deuterocanon
    :param trans: Requested translation
    """
    if testament == "Old Testament":
        testament = "has_ot"
    elif testament == "New Testament":
        testament = "has_nt"
    else:
        testament = "has_deut"
    cur.execute("SELECT %s, available FROM translation_stats "
                "WHERE trans = '%s';" % (testament, trans))
    try:
        in_testament, is_available = cur.fetchone()
        if in_testament and bool(is_available):
            return True
        else:
            return False
    except TypeError:
        return False


def increment_comment_count():
    """ Increments the comment count entry whenever a new comment
    has been made. """

    cur.execute("UPDATE comment_count SET t_count = t_count + 1;")
    _conn.commit()


def decrement_comment_count():
    """ Decrements the comment count entry whenever a comment is deleted. """

    cur.execute("UPDATE comment_count SET t_count = t_count - 1;")
    _conn.commit()


def update_db_stats(verse_list):
    """ Iterates through all verses in verse_list and adds them to dicts
    to pass to the database update functions.

    :param verse_list: List of recently quoted verses
    """
    books = dict()
    translations = dict()
    subreddits = dict()

    for verse in verse_list:
        book = verse.book
        translation = verse.translation
        subreddit = verse.subreddit

        if book in books:
            books[book] += 1
        else:
            books[book] = 1

        if translation in translations:
            translations[translation] += 1
        else:
            translations[translation] = 1

        if subreddit in subreddits:
            subreddits[subreddit] += 1
        else:
            subreddits[subreddit] = 1

    update_book_stats(books)
    update_trans_stats(translations)
    update_subreddit_stats(subreddits)


def remove_invalid_stats(msg, subreddit):
    """ Performs necessary database operations to fix invalid statistics after
    a user has requested a comment to be edited or deleted.

    :param subreddit: Subreddit where the quotation is located
    :param msg: Message containing verse quotations
    """
    invalid_verses = find_already_quoted_verses(msg)
    invalid_books = dict()
    invalid_trans = dict()
    invalid_sub = dict()

    for verse in invalid_verses:
        book = verse[0].rstrip()
        trans = verse[1]
        if book in invalid_books:
            invalid_books[book] += 1
        else:
            invalid_books[book] = 1

        if trans in invalid_trans:
            invalid_trans[trans] += 1
        else:
            invalid_trans[trans] = 1

        if subreddit in invalid_sub:
            invalid_sub[subreddit] += 1
        else:
            invalid_sub[subreddit] = 1

    update_book_stats(invalid_books, is_edit_or_delete=True)
    update_trans_stats(invalid_trans, is_edit_or_delete=True)
    update_subreddit_stats(invalid_sub, is_edit_or_delete=True)
