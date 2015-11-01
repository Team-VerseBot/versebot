/*
  VerseBot for reddit
  By Matthieu Grieger
  create_translation_table.sql
  Copyright (c) 2015 Matthieu Grieger (MIT License)
*/

CREATE TABLE translation_stats (
    id INTEGER,
    name TEXT,
    trans TEXT,
    lang TEXT,
    t_count INTEGER DEFAULT 0,
    has_ot BOOLEAN DEFAULT TRUE,
    has_nt BOOLEAN DEFAULT TRUE,
    has_deut BOOLEAN DEFAULT FALSE,
    available BOOLEAN DEFAULT FALSE,
    last_used DATETIME DEFAULT NULL
);

CREATE TRIGGER update_translation_stats_timestamp AFTER UPDATE ON translation_stats
    BEGIN
        UPDATE translation_stats
        SET last_used = datetime('now') WHERE id = NEW.id;
    END;