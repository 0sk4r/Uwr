-- Podaj kody, imiona i nazwiska wszystkich osób, które chodziły na dowolne zajęcia z Algorytmów i struktur danych,
-- a w jakimś semestrze późniejszym (o większym numerze) chodziły na zajęcia z Matematyki dyskretnej.
-- Za AiSD oraz MD uznaj wszystkie przedmioty, których nazwa zaczyna się od podanych nazw.
-- Zapisz to zapytanie używając operatora IN z podzapytaniem.

SELECT
  uzytkownik.kod_uz,
  imie,
  nazwisko
FROM uzytkownik
  JOIN wybor USING (kod_uz)
  JOIN grupa USING (kod_grupy)
  JOIN przedmiot_semestr ps1 USING (kod_przed_sem)
  JOIN przedmiot USING (kod_przed)
WHERE nazwa LIKE 'Algorytmy i struktury danych%' AND uzytkownik.kod_uz IN
                                                     (
                                                       SELECT uzytkownik.kod_uz
                                                       FROM uzytkownik
                                                         JOIN wybor USING (kod_uz)
                                                         JOIN grupa USING (kod_grupy)
                                                         JOIN przedmiot_semestr USING (kod_przed_sem)
                                                         JOIN przedmiot USING (kod_przed)
                                                       WHERE nazwa LIKE 'Matematyka dyskretna%'
                                                             AND semestr_id > ps1.semestr_id + 1
                                                     );

SELECT
  uzytkownik.kod_uz,
  imie,
  nazwisko
FROM uzytkownik
  JOIN wybor USING (kod_uz)
  JOIN grupa USING (kod_grupy)
  JOIN przedmiot_semestr ps USING (kod_przed_sem)
  JOIN przedmiot USING (kod_przed)
WHERE nazwa LIKE 'Algorytmy i struktury danych%'
      AND uzytkownik.kod_uz IN
          (SELECT wybor.kod_uz
           FROM wybor
             JOIN grupa USING (kod_grupy)
             JOIN przedmiot_semestr USING (kod_przed_sem)
             JOIN przedmiot USING (kod_przed)
           WHERE nazwa LIKE 'Matematyka dyskretna%'
                 AND ps.semestr_id < semestr_id);


SELECT
  uzytkownik.kod_uz,
  imie,
  nazwisko
FROM uzytkownik
  JOIN wybor USING (kod_uz)
  JOIN grupa USING (kod_grupy)
  JOIN przedmiot_semestr ps1 USING (kod_przed_sem)
  JOIN przedmiot USING (kod_przed)
WHERE nazwa LIKE 'Algorytmy i struktury danych%' AND EXISTS
(
    SELECT u2.kod_uz
    FROM uzytkownik u2
      JOIN wybor USING (kod_uz)
      JOIN grupa USING (kod_grupy)
      JOIN przedmiot_semestr USING (kod_przed_sem)
      JOIN przedmiot USING (kod_przed)
    WHERE nazwa LIKE 'Matematyka dyskretna%'
          AND semestr_id > ps1.semestr_id + 1 AND uzytkownik.kod_uz = u2.kod_uz
);

-- 3.Podaj kody, imiona i nazwiska osób, które prowadziły jakiś wykład,
-- ale nigdy nie prowadziły żadnego seminarium (nie patrzymy, czy zajęcia były w tym samym semestrze).
-- Pisząc zapytanie użyj operatora NOT EXISTS.

SELECT DISTINCT
  kod_uz,
  imie,
  nazwisko
FROM grupa g1
  JOIN uzytkownik USING (kod_uz)
WHERE rodzaj_zajec = 'w' AND NOT EXISTS(SELECT *
                                        FROM grupa
                                        WHERE rodzaj_zajec = 's' AND kod_uz = g1.kod_uz);

-- 4.Zapisz zapytanie trzecie, używając różnicy zbiorów.

(SELECT
   uzytkownik.kod_uz,
   imie,
   nazwisko
 FROM grupa
   JOIN uzytkownik USING (kod_uz)
 WHERE rodzaj_zajec = 'w')
EXCEPT
(SELECT
   uzytkownik.kod_uz,
   imie,
   nazwisko
 FROM grupa
   JOIN uzytkownik USING (kod_uz)
 WHERE rodzaj_zajec = 's');

-- 5.Dla każdego przedmiotu typu kurs z bazy danych podaj jego nazwę oraz liczbę osób, które na niego uczęszczały.
-- Uwzględnij w odpowiedzi kursy, na które nikt nie uczęszczał – w tym celu użyj złączenia zewnętrznego (LEFT JOIN lub RIGHT JOIN).

SELECT
  przedmiot.nazwa,
  wybor.kod_uz
FROM przedmiot
  JOIN przedmiot_semestr USING (kod_przed)
  JOIN grupa USING (kod_przed_sem)
  JOIN wybor USING (kod_grupy)
WHERE rodzaj = 'k'
GROUP BY przedmiot.kod_przed, przedmiot.nazwa;


SELECT
  przedmiot.nazwa,
  COUNT(DISTINCT wybor.kod_uz)
FROM
  przedmiot
  LEFT JOIN przedmiot_semestr USING (kod_przed)
  LEFT JOIN grupa USING (kod_przed_sem)
  LEFT JOIN wybor USING (kod_grupy)
WHERE rodzaj = 'k'
GROUP BY przedmiot.kod_przed, przedmiot.nazwa;

--6.Podaj kody użytkowników, którzy uczęszczali w semestrze letnim 2010/2011 na wykład z 'Baz danych' i nie uczęszczali
--  na wykład z 'Sieci komputerowych', i odwrotnie. Sformułuj to zapytanie używając instrukcji WITH,
--  by wstępnie zdefiniować zbiory osób uczęszczających na każdy z wykładów.

WITH bd AS (
    SELECT uzytkownik.kod_uz
    FROM uzytkownik
      JOIN wybor USING (kod_uz)
      JOIN grupa USING (kod_grupy)
      JOIN przedmiot_semestr USING (kod_przed_sem)
      JOIN przedmiot USING (kod_przed)
      JOIN semestr USING (semestr_id)
    WHERE przedmiot.nazwa = 'Bazy danych' AND rodzaj_zajec = 'w'
          AND semestr.nazwa = 'Semestr letni 2010/2011'
), sieci AS (
    SELECT uzytkownik.kod_uz
    FROM uzytkownik
      JOIN wybor USING (kod_uz)
      JOIN grupa USING (kod_grupy)
      JOIN przedmiot_semestr USING (kod_przed_sem)
      JOIN przedmiot USING (kod_przed)
      JOIN semestr USING (semestr_id)
    WHERE przedmiot.nazwa = 'Sieci komputerowe' AND rodzaj_zajec = 'w'
          AND semestr.nazwa = 'Semestr letni 2010/2011'
)
SELECT kod_uz
FROM bd EXCEPT (SELECT *
                FROM sieci);

-- 7.Podaj kody, imiona i nazwiska wszystkich prowadzących, którzy w jakiejś prowadzonej przez siebie grupie mieli więcej zapisanych osób,
--  niż wynosił limit max_osoby dla tej grupy. Do zapisania zapytania użyj GROUP BY i HAVING.

SELECT DISTINCT grupa.kod_uz AS zapisani
FROM grupa
  JOIN uzytkownik USING (kod_uz)
  JOIN wybor USING (kod_grupy)
GROUP BY kod_grupy, uzytkownik.nazwisko, grupa.kod_uz
HAVING (count(wybor.kod_uz) > grupa.max_osoby);

SELECT DISTINCT
  uzytkownik.kod_uz,
  imie,
  nazwisko
FROM
  wybor
  JOIN grupa USING (kod_grupy)
  JOIN uzytkownik ON (uzytkownik.kod_uz = grupa.kod_uz)
GROUP BY grupa.kod_grupy,
  uzytkownik.kod_uz, imie, nazwisko, max_osoby
HAVING max_osoby < COUNT(*);

-- 8.Podaj nazwę przedmiotu podstawowego, na wykład do którego chodziło najwięcej różnych osób.
-- Użyj w tym celu zapytania z GROUP BY i HAVING (z warunkiem używającym ponownie GROUP BY).

SELECT przedmiot.nazwa
FROM przedmiot
  JOIN przedmiot_semestr USING (kod_przed)
  JOIN grupa USING (kod_przed_sem)
  JOIN wybor USING (kod_grupy)
WHERE rodzaj = 'p' AND rodzaj_zajec = 'w'
GROUP BY przedmiot.nazwa, przedmiot.kod_przed
HAVING COUNT(DISTINCT wybor.kod_uz) >=
ALL
       (SELECT COUNT(DISTINCT wybor.kod_uz)
        FROM przedmiot
          JOIN przedmiot_semestr USING (kod_przed)
          JOIN grupa USING (kod_przed_sem)
          JOIN wybor USING (kod_grupy)
        WHERE rodzaj = 'p' AND rodzaj_zajec = 'w'


        GROUP BY przedmiot.kod_przed);

-- 9.Dla każdego semestru letniego podaj jego numer oraz nazwisko osoby, która jako pierwsza zapisała się na zajęcia w tym semestrze.
--  Jeśli w semestrze było kilka osób, które zapisały się jednocześnie:
-- podaj wszystkie;
-- podaj tę o najwcześniejszym leksykograficznie nazwisku.

SELECT wybor.kod_uz, s1.nazwa, wybor.data, u.nazwisko
FROM semestr s1
  JOIN przedmiot_semestr USING (semestr_id)
  JOIN grupa USING (kod_przed_sem)
  JOIN wybor USING (kod_grupy)
  JOIN uzytkownik u ON wybor.kod_uz = u.kod_uz
WHERE wybor.data >= ALL (
  SELECT wybor.data FROM semestr s2
  JOIN przedmiot_semestr USING (semestr_id)
  JOIN grupa USING (kod_przed_sem)
  JOIN wybor USING (kod_grupy)
  WHERE s1.nazwa = s2.nazwa
);

SELECT semestr.semestr_id, MIN(data) FROM semestr
 JOIN przedmiot_semestr USING(semestr_id)
 JOIN grupa USING(kod_przed_sem)
 JOIN wybor USING(kod_grupy)
WHERE nazwa LIKE '%letni%'
GROUP BY semestr.semestr_id;


-- 10.Jaka jest średnia liczba osób zapisujących się na wykład w semestrze letnim 2010/2011?
-- Zapisz to zapytanie definiując najpierw pomocniczą relację (
-- np. na liście from z aliasem), w której dla każdego interesującego cię wykładu znajdziesz
-- liczbę zapisanych na niego osób).

