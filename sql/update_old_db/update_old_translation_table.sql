/*
  VerseBot for reddit
  By Matthieu Grieger
  update_old_translation_table.sql
  Copyright (c) 2015 Matthieu Grieger (MIT License)
*/

ALTER TABLE translation_stats ALTER COLUMN trans TYPE TEXT;
ALTER TABLE translation_stats ALTER COLUMN last_used TYPE TIMESTAMP WITH TIME ZONE;
ALTER TABLE translation_stats ALTER COLUMN last_used SET DEFAULT NULL;

ALTER TABLE translation_stats ADD COLUMN name TYPE TEXT;
ALTER TABLE translation_stats ADD COLUMN lang TYPE TEXT;
ALTER TABLE translation_stats ADD COLUMN has_ot BOOLEAN DEFAULT TRUE;
ALTER TABLE translation_stats ADD COLUMN has_nt BOOLEAN DEFAULT TRUE;
ALTER TABLE translation_stats ADD COLUMN has_deut BOOLEAN DEFAULT FALSE;

ALTER TABLE translation_stats DISABLE TRIGGER update_translation_stats_timestamp;
UPDATE translation_stats SET trans = 'NET Bible' WHERE trans = 'NET';

UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'AMU';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'ERV-BG';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'CCO';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'APSD-CEB';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'CHR';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'CKW';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'SNC';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'HOF';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'NGU-DE';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'CEB';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'DRA';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'GNT';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'PHILLIPS';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'MOUNCE';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'NRSV';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'NRSVA';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'RSV';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'WE';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'DHH';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'TLA';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'TR1550';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'WHNU';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'TR1894';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'SBLGNT';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'HHH';
UPDATE translation_stats SET has_nt = FALSE WHERE trans = 'WLC';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'CRO';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'HWP';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'BDG';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'CEI';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'JAC';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'KEK';
UPDATE translation_stats SET has_deut = TRUE WHERE trans = 'VULGATE';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'MNT';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'MVC';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'MVJ';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'REIMER';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'NGU';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'LB';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'NP';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'SZ-PL';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'NBTN';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'VFL';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'MTDS';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'QUT';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'ERV-RU';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'NPK';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'ERV-SR';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'SNT';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'ERV-TH';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'SND';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'NA-TWI';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'ERV-UK';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'USP';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'ERV-ZH';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'CSBS';
UPDATE translation_stats SET has_ot = FALSE WHERE trans = 'CSBT';

UPDATE translation_stats SET name = 'Amuzgo de Guerrero' WHERE trans = 'AMU';
UPDATE translation_stats SET name = 'Arabic Bible: Easy-to-Read Version' WHERE trans = 'ERV-AR';
UPDATE translation_stats SET name = 'Arabic Life Application Bible' WHERE trans = 'ALAB';
UPDATE translation_stats SET name = 'Awadhi Bible: Easy-to-Read Version' WHERE trans = 'ERV-AWA';
UPDATE translation_stats SET name = '1940 Bulgarian Bible' WHERE trans = 'BG1940';
UPDATE translation_stats SET name = 'Bulgarian Bible' WHERE trans = 'BULG';
UPDATE translation_stats SET name = 'Bulgarian New Testament: Easy-to-Read Version' WHERE trans = 'ERV-BG';
UPDATE translation_stats SET name = 'Bulgarian Protestant Bible' WHERE trans = 'BPB';
UPDATE translation_stats SET name = 'Chinanteco de Comaltepec' WHERE trans = 'CCO';
UPDATE translation_stats SET name = 'Ang Pulong Sa Dios' WHERE trans = 'APSD-CEB';
UPDATE translation_stats SET name = 'Cherokee New Testament' WHERE trans = 'CHR';
UPDATE translation_stats SET name = 'Cakchiquel Occidental' WHERE trans = 'CKW';
UPDATE translation_stats SET name = 'Bible 21' WHERE trans = 'B21';
UPDATE translation_stats SET name = 'Slovo na cestu' WHERE trans = 'SNC';
UPDATE translation_stats SET name = 'Bibelen på hverdagsdansk' WHERE trans = 'BPH';
UPDATE translation_stats SET name = 'Dette er Biblen på dansk' WHERE trans = 'DN1933';
UPDATE translation_stats SET name = 'Hoffnung für Alle' WHERE trans = 'HOF';
UPDATE translation_stats SET name = 'Luther Bibel 1545' WHERE trans = 'LUTH1545';
UPDATE translation_stats SET name = 'Neue Genfer Übersetzung' WHERE trans = 'NGU-DE';
UPDATE translation_stats SET name = 'Schlachter 1951' WHERE trans = 'SCH1951';
UPDATE translation_stats SET name = 'Schlachter 2000' WHERE trans = 'SCH2000';
UPDATE translation_stats SET name = '21st Century King James Version' WHERE trans = 'KJ21';
UPDATE translation_stats SET name = 'American Standard Version' WHERE trans = 'ASV';
UPDATE translation_stats SET name = 'Amplified Bible' WHERE trans = 'AMP';
UPDATE translation_stats SET name = 'Common English Bible' WHERE trans = 'CEB';
UPDATE translation_stats SET name = 'Complete Jewish Bible' WHERE trans = 'CJB';
UPDATE translation_stats SET name = 'Contemporary English Version' WHERE trans = 'CEV';
UPDATE translation_stats SET name = 'Darby Translation' WHERE trans = 'DARBY';
UPDATE translation_stats SET name = 'Douay-Rheims 1899 American Edition' WHERE trans = 'DRA';
UPDATE translation_stats SET name = 'Easy-to-Read Version' WHERE trans = 'ERV';
UPDATE translation_stats SET name = 'English Standard Version' WHERE trans = 'ESV';
UPDATE translation_stats SET name = 'English Standard Version Anglicised' WHERE trans = 'ESVUK';
UPDATE translation_stats SET name = 'Expanded Bible' WHERE trans = 'EXB';
UPDATE translation_stats SET name = '1599 Geneva Bible' WHERE trans = 'GNV';
UPDATE translation_stats SET name = 'GOD’S WORD Translation' WHERE trans = 'GW';
UPDATE translation_stats SET name = 'Good News Translation' WHERE trans = 'GNT';
UPDATE translation_stats SET name = 'Holman Christian Standard Bible' WHERE trans = 'HCSB';
UPDATE translation_stats SET name = 'J.B. Phillips New Testament' WHERE trans = 'PHILLIPS';
UPDATE translation_stats SET name = 'Jubilee Bible 2000' WHERE trans = 'JUB';
UPDATE translation_stats SET name = 'King James Version' WHERE trans = 'KJV';
UPDATE translation_stats SET name = 'Authorized (King James) Version' WHERE trans = 'AKJV';
UPDATE translation_stats SET name = 'Lexham English Bible' WHERE trans = 'LEB';
UPDATE translation_stats SET name = 'Living Bible' WHERE trans = 'TLB';
UPDATE translation_stats SET name = 'The Message' WHERE trans = 'MSG';
UPDATE translation_stats SET name = 'Mounce Reverse-Interlinear New Testament' WHERE trans = 'MOUNCE';
UPDATE translation_stats SET name = 'Names of God Bible' WHERE trans = 'NOG';
UPDATE translation_stats SET name = 'New American Standard Bible' WHERE trans = 'NASB';
UPDATE translation_stats SET name = 'New Century Version' WHERE trans = 'NCV';
UPDATE translation_stats SET name = 'New English Translation' WHERE trans = 'NET Bible';
UPDATE translation_stats SET name = "New International Reader's Version" WHERE trans = 'NIRV';
UPDATE translation_stats SET name = 'New International Version' WHERE trans = 'NIV';
UPDATE translation_stats SET name = 'New International Version - UK' WHERE trans = 'NIVUK';
UPDATE translation_stats SET name = 'New King James Version' WHERE trans = 'NKJV';
UPDATE translation_stats SET name = 'New Life Version' WHERE trans = 'NLV';
UPDATE translation_stats SET name = 'New Living Translation' WHERE trans = 'NLT';
UPDATE translation_stats SET name = 'New Revised Standard Version' WHERE trans = 'NRSV';
UPDATE translation_stats SET name = 'New Revised Standard Version, Anglicised' WHERE trans = 'NRSVA';
UPDATE translation_stats SET name = 'New Revised Standard Version, Anglicised Catholic Edition' WHERE trans = 'NRSVACE';
UPDATE translation_stats SET name = 'New Revised Standard Version Catholic Edition' WHERE trans = 'NRSVCE';
UPDATE translation_stats SET name = 'Orthodox Jewish Bible' WHERE trans = 'OJB';
UPDATE translation_stats SET name = 'Revised Standard Version' WHERE trans = 'RSV';
UPDATE translation_stats SET name = 'Revised Standard Version Catholic Edition' WHERE trans = 'RSVCE';
UPDATE translation_stats SET name = 'The Voice' WHERE trans = 'VOICE';
UPDATE translation_stats SET name = 'World English Bible' WHERE trans = 'WEB';
UPDATE translation_stats SET name = 'Worldwide English (New Testament)' WHERE trans = 'WE';
UPDATE translation_stats SET name = 'Wycliffe Bible' WHERE trans = 'WYC';
UPDATE translation_stats SET name = "Young's Literal Translation" WHERE trans = 'YLT';
UPDATE translation_stats SET name = 'La Biblia de las Américas' WHERE trans = 'LBLA';
UPDATE translation_stats SET name = 'Dios Habla Hoy' WHERE trans = 'DHH';
UPDATE translation_stats SET name = 'Jubilee Bible 2000 (Spanish)' WHERE trans = 'JBS';
UPDATE translation_stats SET name = 'Nueva Biblia Latinoamericana de Hoy' WHERE trans = 'NBLH';
UPDATE translation_stats SET name = 'Nueva Traducción Viviente' WHERE trans = 'NTV';
UPDATE translation_stats SET name = 'Nueva Versión Internacional (Castilian)' WHERE trans = 'CST';
UPDATE translation_stats SET name = 'Nueva Versión Internacional' WHERE trans = 'NVI';
UPDATE translation_stats SET name = 'Palabra de Dios para Todos' WHERE trans = 'PDT';
UPDATE translation_stats SET name = 'La Palabra (España)' WHERE trans = 'BLP';
UPDATE translation_stats SET name = 'La Palabra (Hispanoamérica)' WHERE trans = 'BLPH';
UPDATE translation_stats SET name = 'Reina Valera Contemporánea' WHERE trans = 'RVC';
UPDATE translation_stats SET name = 'Reina-Valera 1960' WHERE trans = 'RVR1960';
UPDATE translation_stats SET name = 'Reina Valera 1977' WHERE trans = 'RVR1977';
UPDATE translation_stats SET name = 'Reina-Valera 1995' WHERE trans = 'RVR1995';
UPDATE translation_stats SET name = 'Reina-Valera Antigua' WHERE trans = 'RVA';
UPDATE translation_stats SET name = 'Traducción en lenguaje actual' WHERE trans = 'TLA';
UPDATE translation_stats SET name = 'Raamattu 1933/38' WHERE trans = 'R1933';
UPDATE translation_stats SET name = 'La Bible du Semeur' WHERE trans = 'BDS';
UPDATE translation_stats SET name = 'Louis Segond' WHERE trans = 'LSG';
UPDATE translation_stats SET name = 'Nouvelle Edition de Genève – NEG1979' WHERE trans = 'NEG1979';
UPDATE translation_stats SET name = 'Segond 21' WHERE trans = 'SG21';
UPDATE translation_stats SET name = '1550 Stephanus New Testament' WHERE trans = 'TR1550';
UPDATE translation_stats SET name = '1881 Westcott-Hort New Testament' WHERE trans = 'WHNU';
UPDATE translation_stats SET name = '1894 Scrivener New Testament' WHERE trans = 'TR1894';
UPDATE translation_stats SET name = 'SBL Greek New Testament' WHERE trans = 'SBLGNT';
UPDATE translation_stats SET name = 'Habrit Hakhadasha/Haderekh' WHERE trans = 'HHH';
UPDATE translation_stats SET name = 'The Westminster Leningrad Codex' WHERE trans = 'WLC';
UPDATE translation_stats SET name = 'Hindi Bible: Easy-to-Read Version' WHERE trans = 'ERV-HI';
UPDATE translation_stats SET name = 'Ang Pulong Sang Dios' WHERE trans = 'HLGN';
UPDATE translation_stats SET name = 'Knijga O Kristu' WHERE trans = 'CRO';
UPDATE translation_stats SET name = 'Haitian Creole Version' WHERE trans = 'HCV';
UPDATE translation_stats SET name = 'Hungarian Károli' WHERE trans = 'KAR';
UPDATE translation_stats SET name = 'Hungarian Bible: Easy-to-Read Version' WHERE trans = 'ERV-HU';
UPDATE translation_stats SET name = 'Hungarian New Translation' WHERE trans = 'NT-HU';
UPDATE translation_stats SET name = 'Hawai‘i Pidgin' WHERE trans = 'HWP';
UPDATE translation_stats SET name = 'Icelandic Bible' WHERE trans = 'ICELAND';
UPDATE translation_stats SET name = 'La Bibbia della Gioia' WHERE trans = 'BDG';
UPDATE translation_stats SET name = 'Conferenza Episcopale Italiana' WHERE trans = 'CEI';
UPDATE translation_stats SET name = 'La Nuova Diodati' WHERE trans = 'LND';
UPDATE translation_stats SET name = 'Nuova Riveduta 1994' WHERE trans = 'NR1994';
UPDATE translation_stats SET name = 'Nuova Riveduta 2006' WHERE trans = 'NR2006';
UPDATE translation_stats SET name = 'Jacalteco, Oriental' WHERE trans = 'JAC';
UPDATE translation_stats SET name = 'Kekchi' WHERE trans = 'KEK';
UPDATE translation_stats SET name = 'Biblia Sacra Vulgata' WHERE trans = 'VULGATE';
UPDATE translation_stats SET name = 'Maori Bible' WHERE trans = 'MAORI';
UPDATE translation_stats SET name = 'Macedonian New Testament' WHERE trans = 'MNT';
UPDATE translation_stats SET name = 'Marathi Bible: Easy-to-Read Version' WHERE trans = 'ERV-MR';
UPDATE translation_stats SET name = 'Mam, Central' WHERE trans = 'MVC';
UPDATE translation_stats SET name = 'Mam de Todos Santos Chuchumatán' WHERE trans = 'MVJ';
UPDATE translation_stats SET name = 'Reimer 2001' WHERE trans = 'REIMER';
UPDATE translation_stats SET name = 'Nepali Bible: Easy-to-Read Version' WHERE trans = 'ERV-NE';
UPDATE translation_stats SET name = 'Náhuatl de Guerrero' WHERE trans = 'NGU';
UPDATE translation_stats SET name = 'Het Boek' WHERE trans = 'HTB';
UPDATE translation_stats SET name = 'Det Norsk Bibelselskap 1930' WHERE trans = 'DNB1930';
UPDATE translation_stats SET name = 'En Levende Bok' WHERE trans = 'LB';
UPDATE translation_stats SET name = 'Oriya Bible: Easy-to-Read Version' WHERE trans = 'ERV-OR';
UPDATE translation_stats SET name = 'Punjabi Bible: Easy-to-Read Version' WHERE trans = 'ERV-PA';
UPDATE translation_stats SET name = 'Nowe Przymierze' WHERE trans = 'NP';
UPDATE translation_stats SET name = 'Słowo Życia' WHERE trans = 'SZ-PL';
UPDATE translation_stats SET name = 'Ne Bibliaj Tik Nawat' WHERE trans = 'NBTN';
UPDATE translation_stats SET name = 'João Ferreira de Almeida Atualizada' WHERE trans = 'AA';
UPDATE translation_stats SET name = 'Nova Versão Internacional' WHERE trans = 'NVI-PT';
UPDATE translation_stats SET name = 'O Livro' WHERE trans = 'OL';
UPDATE translation_stats SET name = 'Portuguese New Testament: Easy-to-Read Version' WHERE trans = 'VFL';
UPDATE translation_stats SET name = 'Mushuj Testamento Diospaj Shimi' WHERE trans = 'MTDS';
UPDATE translation_stats SET name = 'Quiché, Centro Occidental' WHERE trans = 'QUT';
UPDATE translation_stats SET name = 'Cornilescu' WHERE trans = 'RMNN';
UPDATE translation_stats SET name = 'Nouă Traducere În Limba Română' WHERE trans = 'NTLR';
UPDATE translation_stats SET name = 'Russian New Testament: Easy-to-Read Version' WHERE trans = 'ESV-RU';
UPDATE translation_stats SET name = 'Russian Synodal Version' WHERE trans = 'RUSV';
UPDATE translation_stats SET name = 'Slovo Zhizny' WHERE trans = 'SZ';
UPDATE translation_stats SET name = 'Nádej pre kazdého' WHERE trans = 'NPK';
UPDATE translation_stats SET name = 'Somali Bible' WHERE trans = 'SOM';
UPDATE translation_stats SET name = 'Albanian Bible' WHERE trans = 'ALB';
UPDATE translation_stats SET name = 'Serbian New Testament: Easy-to-Read Version' WHERE trans = 'ERV-SR';
UPDATE translation_stats SET name = 'Nya Levande Bibeln' WHERE trans = 'SVL';
UPDATE translation_stats SET name = 'Svenska 1917' WHERE trans = 'SV1917';
UPDATE translation_stats SET name = 'Svenska Folkbibeln' WHERE trans = 'SFB';
UPDATE translation_stats SET name = 'Neno: Bibilia Takatifu' WHERE trans = 'SNT';
UPDATE translation_stats SET name = 'Tamil Bible: Easy-to-Read Version' WHERE trans = 'ERV-TA';
UPDATE translation_stats SET name = 'Thai New Contemporary Bible' WHERE trans = 'TNCV';
UPDATE translation_stats SET name = 'Thai New Testament: Easy-to-Read Version' WHERE trans = 'ERV-TH';
UPDATE translation_stats SET name = 'Ang Salita ng Diyos' WHERE trans = 'SND';
UPDATE translation_stats SET name = 'Nkwa Asem' WHERE trans = 'NA-TWI';
UPDATE translation_stats SET name = 'Ukrainian Bible' WHERE trans = 'UKR';
UPDATE translation_stats SET name = 'Ukrainian New Testament: Easy-to-Read Version' WHERE trans = 'ERV-UK';
UPDATE translation_stats SET name = 'Urdu Bible: Easy-to-Read Version' WHERE trans = 'ERV-UR';
UPDATE translation_stats SET name = 'Uspanteco' WHERE trans = 'USP';
UPDATE translation_stats SET name = '1934 Vietnamese Bible' WHERE trans = 'VIET';
UPDATE translation_stats SET name = 'Bản Dịch 2011' WHERE trans = 'BD2011';
UPDATE translation_stats SET name = 'Vietnamese Bible: Easy-to-Read Version' WHERE trans = 'BPT';
UPDATE translation_stats SET name = 'Chinese Contemporary Bible' WHERE trans = 'CCB';
UPDATE translation_stats SET name = 'Chinese New Testament: Easy-to-Read Version' WHERE trans = 'ERV-ZH';
UPDATE translation_stats SET name = 'Chinese New Version (Traditional)' WHERE trans = 'CNVT';
UPDATE translation_stats SET name = 'Chinese Standard Bible (Simplified)' WHERE trans = 'CSBS';
UPDATE translation_stats SET name = 'Chinese Standard Bible (Traditional)' WHERE trans = 'CSBT';
UPDATE translation_stats SET name = 'Chinese Union Version (Simplified)' WHERE trans = 'CUVS';
UPDATE translation_stats SET name = 'Chinese Union Version (Traditional)' WHERE trans = 'CUV';
UPDATE translation_stats SET name = 'Chinese Union Version Modern Punctuation (Simplified)' WHERE trans = 'CUVMPS';
UPDATE translation_stats SET name = 'Chinese Union Version Modern Punctuation (Traditional)' WHERE trans = 'CUVMPT';
UPDATE translation_stats SET name = 'JPS Tanakh' WHERE trans = 'NJPS';
UPDATE translation_stats SET name = 'New American Bible (Revised Edition)' WHERE trans = 'NABRE';
ALTER TABLE translation_stats ENABLE TRIGGER update_translation_stats_timestamp;
