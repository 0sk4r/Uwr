%Oskar Sobczyk

%predykat zwracajacy zanegowany literal
negacja(~ Literal,X):-
X = Literal, 
!.
negacja(Literal,X):-
X = ~Literal, 
!.

%predykat sprawdzajacy czy dla dwoch klauzul mozna zastosowac regule rezolucji
%bierze kolejne literaly z pierwszej klauzuli, neguje je a nastepnie sprawdza czy
%wystepuje on w drugiej klauzuli, jezeli tak to tworzy nowa liste zlozona z klauzul
%bez eliminujacych sie literalow

rezolwenta(Klauzula1,Klauzula2,Rezolwenta):-
	rezolwenta(Klauzula1,Klauzula2,Klauzula1,Klauzula2,Rezolwenta).

rezolwenta(Acc1,Acc2,[Literal|Klauzula1],Klauzula2,Rezolwenta):-
	negacja(Literal,Nliteral),
	member(Nliteral,Klauzula2),
	delete(Acc1,Literal,Lista1),
	delete(Acc2,Nliteral,Lista2),
	append(Lista1,Lista2,Rezolwenta),
	!.

rezolwenta(Acc1,Acc2, [Literal | Klauzula1], Klauzula2,Rezolwenta):-
	rezolwenta(Acc1,Acc2, Klauzula1, Klauzula2, Rezolwenta),
	!.

rezolwenta(Acc1,Acc2,Literal, Klauzula2,Rezolwenta):-
	negacja(Literal,Nliteral),
	member(Nliteral,Klauzula2),
	delete(Acc1,Literal,Lista1),
	delete(Acc2,Nliteral,Lista2),
	append(Lista1,Lista2,Rezolwenta).

%predykat przeksztalcajacy klauzule na liste jej literalow
kl2list(H v T,[H|X]):-kl2list(T,X),!.
kl2list(X,[X]).

%predykat zamieniajacy liste klauzul na liste list
tolist([],[]).

tolist([H | T],[H1 | T1]):-
	kl2list(H,H1),
	tolist(T,T1).

%zamienia liste list na liste klauzul
list2kl([H | T],H v X):-list2kl(T,X),!.
list2kl([X],X).

%zamienia liste literalow na klauzule
toklauzule([],[]).

toklauzule([H | T],[H1 | T1]):-
	list2kl(H,H1),
	toklauzule(T,T1).

%predykat szukajacych rezolwent pierwszej klauzuli z listy z pozostalymi
szukaj([H | T], X):-
	szukaj(T,H,X).

szukaj([H|_],M,X):- rezolwenta(M,H,X).
szukaj([_|T],M,X):- szukaj(T,M,X).

%poszukiwanie dowodu polega na tym ze predykat szuka rezolwent do pierwszej 
%klauzuli na liscie ze wszystkimi nastepnymi nastepnie dodaje je na koniec listy
%po czym szuka rezolwent nastepnej klauzuli z klauzulami ktore sa za nią 


%predykat tworzacy dowod rezolucyjny
%inicjalizacja
prove(Klauzula,Dowod):- 
	tolist(Klauzula,Listaklauzul),
	prove(Klauzula,Dowod,Listaklauzul).

prove(Klauzula,Dowod,Listaklauzul):-
	last(Listaklauzul,[]),
	list2kl(Listaklauzul,X),
	Dowod = X,
	!.

prove(Klauzule,Dowod,[H | T]):-
	szukaj([H | T],Rezolwenty),
	append(Dowod,Rezolwenty,Dowod1),
	append(T, Rezolwenty, T1),
	prove(Klauzule,Dowod1,T1).	