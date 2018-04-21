CREATE DOMAIN semestry AS TEXT
  CHECK (
    (VALUE = 'letni' OR VALUE = 'zimowy') AND VALUE IS NOT NULL
  );

CREATE SEQUENCE numer_semestru;

SELECT setval('numer_semestru',max(semestr_id))
FROM semestr;

ALTER TABLE semestr ALTER COLUMN semestr_id
  SET DEFAULT nextval('numer_semestru');

ALTER SEQUENCE numer_semestru OWNED BY semestr.semestr_id;

-- Zadanie 2

ALTER TABLE semestr ADD COLUMN semestr semestry DEFAULT 'zimowy';

ALTER TABLE semestr ADD COLUMN rok VARCHAR(9);

UPDATE semestr SET semestr = 'letni' WHERE semestr.nazwa LIKE '%letni%';

UPDATE semestr SET rok = substring(nazwa FROM position('/' IN nazwa)-4 FOR 9);

ALTER TABLE semestr DROP COLUMN nazwa;


ALTER TABLE semestr ALTER COLUMN semestr DROP DEFAULT;

ALTER TABLE semestr ALTER COLUMN semestr SET DEFAULT
 CASE WHEN extract(month FROM current_date) BETWEEN 1 AND 6
   THEN 'letni' ELSE 'zimowy'
 END;

ALTER TABLE semestr ALTER COLUMN rok SET DEFAULT
 CASE WHEN extract(month FROM current_date) BETWEEN 1 AND 6
   THEN extract(year FROM current_date)-1||'/'||extract(year FROM current_date)
   ELSE extract(year FROM current_date)||'/'||extract(year FROM current_date)+1
 END;

select * from semestr ORDER BY semestr_id;

--ZADANIE 2
INSERT INTO semestr (semestr, rok) VALUES ('zimowy','2013/2014'), ('letni','2013/2014');


CREATE SEQUENCE numer_przedmiot_semestr;

SELECT setval('numer_przedmiot_semestr',max(kod_przed_sem))
FROM przedmiot_semestr;

ALTER TABLE przedmiot_semestr ALTER COLUMN kod_przed_sem
  SET DEFAULT nextval('numer_przedmiot_semestr');

ALTER SEQUENCE numer_przedmiot_semestr OWNED BY przedmiot_semestr.kod_przed_sem;

---------------------------------------------------------------
CREATE SEQUENCE numer_grupy;

SELECT setval('numer_grupy', max(kod_grupy))
FROM grupa;

ALTER TABLE grupa ALTER COLUMN  kod_grupy
    SET DEFAULT nextval('numer_grupy');

ALTER SEQUENCE numer_grupy OWNED BY grupa.kod_grupy;


INSERT INTO przedmiot_semestr
   (semestr_id,kod_przed,strona_domowa, angielski)
   SELECT s1.semestr_id, p.kod_przed, strona_domowa, angielski
  FROM semestr s1,
        przedmiot p JOIN
        przedmiot_semestr ps USING(kod_przed) JOIN
        semestr s USING(semestr_id)
   WHERE rodzaj IN ('p', 'o') AND
         s.rok='2010/2011' AND
         s.semestr=s1.semestr AND
         s1.rok='2013/2014';



ALTER TABLE grupa ALTER COLUMN kod_uz DROP NOT NULL;

INSERT INTO grupa(kod_przed_sem,max_osoby,rodzaj_zajec)
   SELECT kod_przed_sem,100,'w'
   FROM przedmiot_semestr JOIN semestr USING(semestr_id)
   WHERE rok='2013/2014';

SELECT kod_grupy, nazwa, rodzaj_zajec, max_osoby
FROM grupa JOIN
     przedmiot_semestr USING(kod_przed_sem) JOIN
     przedmiot USING(kod_przed) JOIN
     semestr USING(semestr_id)
WHERE rok='2013/2014';