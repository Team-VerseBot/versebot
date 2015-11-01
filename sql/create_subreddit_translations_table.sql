/*
  VerseBot for reddit
  By Matthieu Grieger
  create_subreddit_translations_table.sql
  Copyright (c) 2015 Matthieu Grieger (MIT License)
*/

CREATE TABLE subreddit_translations (
    id INTEGER PRIMARY KEY,
    sub TEXT,
    ot_default TEXT,
    nt_default TEXT,
    deut_default TEXT,
    created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);