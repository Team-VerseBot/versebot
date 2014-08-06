CREATE TABLE book_stats (id SERIAL PRIMARY KEY, book VARCHAR(20), count INTEGER DEFAULT 0, last_used TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW());

INSERT INTO book_stats (book) VALUES ('Genesis'), ('Exodus'), ('Leviticus'), ('Numbers'), ('Deuteronomy'), 
	('Joshua'), ('Judges'), ('Ruth'), ('1 Samuel'), ('2 Samuel'), ('1 Kings'), ('2 Kings'),
	('1 Chronicles'), ('2 Chronicles'), ('Ezra'), ('Nehemiah'), ('Esther'), ('Job'), ('Psalms'),
	('Proverbs'), ('Ecclesiastes'), ('Song of Songs'), ('Isaiah'), ('Jeremiah'), ('Lamentations'),
	('Ezekiel'), ('Daniel'), ('Hosea'), ('Joel'), ('Amos'), ('Obadiah'), ('Jonah'), ('Micah'),
	('Nahum'), ('Habakkuk'), ('Zephaniah'), ('Haggai'), ('Zechariah'), ('Malachi'), ('Matthew'),
	('Mark'), ('Luke'), ('John'), ('Acts'), ('Romans'), ('1 Corinthians'), ('2 Corinthians'),
	('Galatians'), ('Ephesians'), ('Philippians'), ('Colossians'), ('1 Thessalonians'),
	('2 Thessalonians'), ('1 Timothy'), ('2 Timothy'), ('Titus'), ('Philemon'), ('Hebrews'),
	('James'), ('1 Peter'), ('2 Peter'), ('1 John'), ('2 John'), ('3 John'), ('Jude'), ('Revelation'),
	('Judith'), ('Wisdom'), ('Tobit'), ('Ecclesiasticus'), ('Baruch'), ('1 Maccabees'),
	('2 Maccabees'), ('3 Maccabees'), ('4 Maccabees'), ('Prayer of Azariah'), ('Additions to Esther'),
	('Prayer of Manasseh'), ('1 Esdras'), ('2 Esdras'), ('Susanna'), ('Bel and the Dragon');
	
CREATE TRIGGER update_book_stats_timestamp BEFORE UPDATE
    ON book_stats FOR EACH ROW EXECUTE PROCEDURE 
    update_timestamp_column();
