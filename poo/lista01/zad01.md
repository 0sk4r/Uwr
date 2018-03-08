#Zad1

Functionality, localisation: Polskie interfejsy W-37 
Functionality, security: "Komunikacja z systemami zewnętrznymi musi być szyfrowana"W-51 Jakie szyfrowanie?
Usabilitya, asthetics Interfejs użytkownika będzie zaprojektowany w zgodzie z powszechnie przyjętymi standardami
i szeroko pojętymi dobrymi praktykami w dziedzinie konstruowania intuicyjnego interfejsu
użytkownika W-31
Usability, consistency: System musi zapewnić możliwość pobrania i zapisania wybranego raportu do typowych
formatów... W-22
Realiability, accuracy System będzie pracował w trybie 24x7 w-27,28
Suupportability, scalability 500 uzttkownikow w-28

SMART - Simple measurable achievable relevant time specific

#zad2
Problem. Obsługa kolejki w banku. Opis skrócony:
Klient podchodzi do podajnika biletów i wybiera kolejkę, do której chce się zapisać. Klient zostaje ustawiony
na sam koniec kolejki, przyporządkowuje mu numer w kolejce. Klienci są obsługiwani w porządku czasowym,
tj. osoba, która wzięła bilet wcześniej, zostanie obsłużona przed osobami, które wzięły bilet po niej. W
przypadku, gdy następuje kolej klienta, który otrzymał bilet z numerem X, jego numer zostaje wyświetlony
na tablicy ogłoszeniowej wraz z numerem stanowiska, do którego ma podejść. Stanowisko jest zwalniane dla
następnego klienta w przypadku, gdy osoba zarządzająca nim osoba zgłosi gotowość do przyjęcia kolejnej
osoby.

Problem. Wypłata pieniędzy z bankomatu. Opis pełny:
• Nazwa: Wypłata środków z bankomatu i rejestrowanie wypłaty
• Numer: 13
• Twórca: Andrzej Duda
• Poziom ważności: Wysoki
• Typ przypadku zastosowania: Ogólny, niezbędny
• Aktorzy: Klient banku (osoba wypłacająca pieniądze)
• Warunki wstępne: Klient musi mieć wskazaną przez siebie kwotę do wypłaty na koncie bankowym.
Klient musi posiadać aktywną kartę płatniczą i znać czterocyfrowy kod PIN umożliwiający odblokowanie
jej.
• Warunki końcowe: W przypadku odrzucenia przez serwer wprowadzonego przez użytkownika kodu
PIN, bankomat nie wypłacił żadnych pieniędzy. W przypadku zaakceptowania kodu PIN, bankomat
wypłacił wskazaną przez klienta kwotę, a informacja o tej wypłacie została przesłana do serwera, który
zarządza rachunkiem przypisanym do karty płatniczej (o ile są dostępne banknoty do wypłacenia tej
kwoty).
• Główny scenariusz sukcesu:
1. Klient wprowadza kartę płatniczą do bankomatu.
2. Bankomat, w pośrednictwie z serwerem banku, autoryzuje wprowadzoną przez klienta kartę płatniczą.
3a. System czeka na wprowadzenie przez klienta czterocyfrowego kodu PIN.
4. Klient wybiera kwotę, którą chce wypłacić.
5a. Bankomat wysyła do serwera informację o wypłacie i sprawdza, czy na przypisanym do karty
płatniczej rachunku dostępne są środki.
6a. Bankomat wybiera odpowiednie nominały banknotów i wydaje je klientowi i wysyła do serwera
informację do dokonaniu wypłaty.
7. Bankomat oddaje kartę płatniczą wprowadzoną przez użytkownika.
• Alternatywne przepływy zdarzeń:
3b. W przypadku, gdy karta została odrzucona przez bankomat, nie pozwala na dokonanie żadnej
transakcji. Następuje przejście do kroku 7.
5b. W przypadku, gdy kod PIN podany przez klienta nie zgadza się z kodem przypisanym do karty,
powiadamia użytkownika o niepoprawności. Następuje przejście do kroku 7.
6b. W przypadku, gdy w komorze bankomatu nie ma banknotów o nominałach umożliwiających wypłacenie
środków, klient jest informowany o tym fakcie i następuje przejście do kroku 4.
• Dodatkowe wymagania: Brak
• Notatki i kwestie: Brak