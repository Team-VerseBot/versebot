/*
  VerseBot for reddit
  By Matthieu Grieger
  create_subreddit_table.sql
  Copyright (c) 2015 Matthieu Grieger (MIT License)
*/

CREATE TABLE subreddit_stats (
    id INTEGER PRIMARY KEY,
    sub TEXT,
    t_count INTEGER DEFAULT 0,
    last_used DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER update_subreddit_stats_timestamp
AFTER UPDATE OF t_count ON subreddit_stats
    BEGIN
        UPDATE subreddit_stats
        SET last_used = datetime('now') WHERE id = NEW.id;
    END;