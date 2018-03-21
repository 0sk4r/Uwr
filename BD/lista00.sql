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
ORDER BY czas DESC LIMIT 1

SELECT COUNT(DISTINCT nazwa)FROM przedmiot
  JOIN przedmiot_semestr USING (kod_przed)
  JOIN grupa USING (kod_przed_sem)
WHERE rodzaj_zajec = 'e' AND rodzaj = 'o'


