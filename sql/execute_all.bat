@ECHO OFF
for %%f in (*.sql) do sqlite3 versebot_db.sqlite ".read %%f"