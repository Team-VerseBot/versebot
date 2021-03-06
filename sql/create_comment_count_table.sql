/*
  VerseBot for reddit
  By Matthieu Grieger
  create_comment_count_table.sql
  Copyright (c) 2015 Matthieu Grieger (MIT License)
*/

CREATE TABLE comment_count (
    id INTEGER PRIMARY KEY,
    t_count INTEGER DEFAULT 0,
    last_used DATETIME DEFAULT NULL
);

INSERT INTO comment_count DEFAULT VALUES;

CREATE TRIGGER update_comment_count_timestamp
AFTER UPDATE OF t_count ON comment_count
    BEGIN
        UPDATE comment_count
        SET last_used = datetime('now') WHERE id = NEW.id;
    END;