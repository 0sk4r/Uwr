SELECT nazwisko || ', ' FROM uzytkownik
  JOIN grupa USING(kod_uz)
  JOIN przedmiot_semestr USING(kod_przed_sem)
  JOIN przedmiot USING(kod_przed)
  JOIN semestr USING (semestr_id)
WHERE przedmiot.nazwa = 'Matematyka dyskretna (M)' AND
  grupa.rodzaj_zajec = 'c' AND
  semestr.nazwa = 'Semestr zimowy 2010/2011'
ORDER BY nazwisko ASC;

SELECT imie || ' ' || nazwisko FROM uzytkownik
  JOIN wybor USING (kod_uz)
  JOIN grupa USING (kod_grupy)
  JOIN przedmiot_semestr USING (kod_przed_sem)
  JOIN przedmiot USING (kod_przed)
  JOIN semestr USING (semestr_id)
WHERE przedmiot.nazwa = 'Matematyka dyskretna (M)' AND
  semestr.nazwa = 'Semestr zimowy 2010/2011' AND
  grupa.rodzaj_zajec = 'w'
ORDER BY data LIMIT 1;

SELECT kod_grupy FROM wybor
  JOIN grupa USING (kod_grupy)
  JOIN przedmiot_semestr USING (kod_przed_sem)
  JOIN przedmiot USING (kod_przed)
  JOIN semestr USING (semestr_id)
WHERE przedmiot.nazwa = 'Matematyka dyskretna (M)' AND
  semestr.nazwa = 'Semestr zimowy 2010/2011' AND
  grupa.rodzaj_zajec = 'w'
ORDER BY data;

SELECT extract(DAY FROM w1.data - w2.data) as czas
FROM wybor w1, wybor w2
WHERE w1.kod_grupy = w2.kod_grupy AND w1.kod_grupy = 5649
AND w1.data > w2.data
ORDER BY czas DESC LIMIT 1;


--Do ilu przedmiotów obowiązkowych jest repetytorium?
SELECT COUNT(DISTINCT nazwa)FROM przedmiot
  JOIN przedmiot_semestr USING (kod_przed)
  JOIN grupa USING (kod_przed_sem)
WHERE rodzaj_zajec = 'e' AND rodzaj = 'o';

--Ile osób prowadziło ćwiczenia do przedmiotów obowiązkowych w semestrach zimowych? Do odpowiedzi wliczamy sztucznych użytkowników (o “dziwnych” nazwiskach).

SELECT COUNT(DISTINCT kod_uz) FROM uzytkownik
  JOIN grupa g USING (kod_uz)
  JOIN przedmiot_semestr USING (kod_przed_sem)
  JOIN semestr USING (semestr_id)
  JOIN przedmiot USING (kod_przed)
WHERE semestr.nazwa LIKE 'Semestr zimowy%' AND
  rodzaj_zajec IN ('c', 'C') AND
  rodzaj = 'o';

--Podaj nazwy wszystkich przedmiotów (w kolejności alfabetycznej, oddzielone przecinkami,
-- a wewnątrz nazw pojedyńczymi spacjami), do których zajęcia prowadził użytkownik o nazwisku Urban.

SELECT DISTINCT nazwa FROM uzytkownik
  JOIN grupa USING (kod_uz)
  JOIN przedmiot_semestr USING (kod_przed_sem)
  JOIN przedmiot USING (kod_przed)
WHERE nazwisko = 'Urban';

--Ile jest w bazie osób o nazwisku Kabacki z dowolnym numerem na końcu?

SELECT * FROM uzytkownik
WHERE nazwisko LIKE 'Kabacki%';

--Ile osób co najmniej dwukrotnie się zapisało na Algorytmy i struktury danych (M) w różnych semestrach (na dowolne zajęcia)?
SELECT COUNT(DISTINCT u.kod_uz) FROM uzytkownik u
  JOIN wybor w1 USING (kod_uz)
  JOIN grupa g1 USING (kod_grupy)
  JOIN przedmiot_semestr ps1 USING(kod_przed_sem)
  JOIN przedmiot p1 USING (kod_przed)
  JOIN wybor w2 ON (u.kod_uz = w2.kod_uz)
  JOIN grupa g2 on (g2.kod_grupy=w2.kod_grupy)
  JOIN przedmiot_semestr  ps2 on (g2.kod_przed_sem = ps2.kod_przed_sem)
  JOIN przedmiot p2 on (ps2.kod_przed = p2.kod_przed)
WHERE
  p2.nazwa=p1.nazwa
      AND p1.nazwa ='Algorytmy i struktury danych (M)'
      AND ps1.kod_przed_sem<>ps2.kod_przed_sem;



--W którym semestrze (podaj numer) było najmniej przedmiotów obowiązkowych (rozważ tylko semestry, gdy był co najmniej jeden)?
SELECT * FROM semestr;

SELECT count(kod_przed_sem) FROM przedmiot_semestr
  JOIN przedmiot USING (kod_przed)
WHERE semestr_id = 27 AND rodzaj='o';

--ile grup ćwiczeniowych z Logiki dla informatyków  było w semestrze zimowym  2010/2011?
SELECT * FROM grupa
  JOIN przedmiot_semestr USING (kod_przed_sem)
  JOIN przedmiot USING (kod_przed)
  JOIN semestr USING  (semestr_id)
WHERE przedmiot.nazwa LIKE 'Logika%' AND semestr.nazwa = 'Semestr zimowy 2010/2011'
AND rodzaj_zajec in ('c','C')

--Ile przedmiotów ma w nazwie dopisek '(ang.)'?
SELECT count(*) FROM przedmiot
WHERE nazwa LIKE '%(ang.)'

--W jakim okresie (od dnia do dnia) studenci zapisywali się
-- na przedmioty w semestrze zimowym 2009/2010? Podaj odpowiedź w formacie rrrr-mm-dd,rrrr-mm-dd
SELECT w1.data, w2.data, w2.data - w1.data   FROM semestr s
  JOIN przedmiot_semestr ps1 USING (semestr_id)
  JOIN grupa g1 USING (kod_przed_sem)
  JOIN wybor w1 USING (kod_grupy)
  JOIN  przedmiot_semestr ps2 on ps2.semestr_id = s.semestr_id
  JOIN grupa g2 on g2.kod_przed_sem = ps2.kod_przed_sem
  JOIN wybor w2 ON g2.kod_grupy = w2.kod_grupy
WHERE s.nazwa = 'Semestr zimowy 2009/2010'
ORDER BY 3 DESC

SELECT DISTINCT CAST(data AS date)

FROM wybor

      JOIN grupa USING (kod_grupy)

      JOIN przedmiot_semestr USING (kod_przed_sem)

WHERE semestr_id=32

ORDER BY 1;
--Ile przedmiotów typu kurs nie miało edycji w żadnym semestrze (nie występują w tabeli przedmiot_semestr)?
SELECT * FROM przedmiot
WHERE rodzaj = 'k' AND kod_przed not in (SELECT kod_przed FROM przedmiot_semestr WHERE rodzaj = 'k');

(SELECT kod_przed FROM przedmiot WHERE rodzaj='k')
EXCEPT
(SELECT kod_przed FROM przedmiot_semestr);

--Ile grup ćwiczenio-pracowni prowadziła P. Kanarek?

SELECT * FROM grupa
  JOIN uzytkownik USING(kod_uz)
WHERE nazwisko = 'Kanarek' AND rodzaj_zajec = 'r'

--Ile grup z Logiki dla informatyków prowadził W. Charatonik?
SELECT * FROM grupa
  JOIN uzytkownik USING (kod_uz)
  JOIN przedmiot_semestr USING (kod_przed_sem)
  JOiN przedmiot USING (kod_przed)
WHERE nazwisko = 'Charatonik' and nazwa = 'Logika dla informatyków'
SELECT *

FROM przedmiot

      JOIN przedmiot_semestr USING (kod_przed)

      JOIN grupa USING (kod_przed_sem)

      JOIN uzytkownik USING (kod_uz)

WHERE nazwisko='Charatonik'

      AND imie='Witold'

      AND nazwa LIKE 'Logika dla informatyk%w';

--Ile osób uczęszczało dwa razy na Bazy danych?

SELECT * FROM przedmiot WHERE nazwa = 'Bazy danych'

