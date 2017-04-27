% Definiujemy modu� zawieraj�cy rozwi�zanie.
% Nale�y zmieni� nazw� modu�u na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} nale�y podstawi� odpowiednio swoje imi�
% i nazwisko bez wielkich liter oraz znak�w diakrytycznych
%:- module(oskar_sobczyk, [resolve/4, prove/2]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Szukanie rezolwenty.
% UWAGA: to nie jest jeszcze rozwi�zanie; nale�y zmieni� definicj�
% tego predykatu
%resolve(q, p v q, ~q v r, r v p).

% G��wny predykat rozwi�zuj�cy zadanie.
% UWAGA: to nie jest jeszcze rozwi�zanie; nale�y zmieni� jego
% definicj�.



%predykat przeksztalcajacy klauzule na liste jej literalow
kl2list(H v T,[H|X]):-kl2list(T,X),!.
kl2list(X,[X]).

%predykat zamieniajacy liste klauzul na liste list
tolist([],[]).

tolist([H | T],[H2sort | T1]):-
	kl2list(H,H1),
	sort(H1,H2sort),
	tolist(T,T1).

%zamienia liste list na liste klauzul
list2kl([H | []],H) :- !.
list2kl([H | T],H v X):-list2kl(T,X),!.
list2kl([X],X).
list2kl([],[]) :- !.


%zamienia liste literalow na klauzule
toklauzule([],[]).

toklauzule([H | T],[H1 | T1]):-
	list2kl(H,H1),
	toklauzule(T,T1).

%zwraca zanegowany literal
neg(~A, A):-!.
neg(A, ~A).


%dla kazdego literalu w liscie usuwa jego negacje z listy
delNeg([], []) :- !.

delNeg([Var | T],Out) :-
	neg(Var, NegVar),
	member(NegVar, T),
	!,
	delete(T, NegVar, T1),
	delNeg(T1, Out).

delNeg([Var | T], [Var | T1]) :-
	delNeg(T,T1).


%predykat z polecenia

resolve(Var, PosClause, NegClause, Resolvent):-
    kl2list(PosClause, PosList), %zamiana klauzul na listy
    kl2list(NegClause, NegList),
    delete(PosList,Var, Res1),%usuniecie pozytywnego wystapienia
    neg(Var,NegVar), %zanegowanie zmiennej
    delete(NegList, NegVar, Res2), %usuniecie negatywnego wystapienia
    append(Res1, Res2, List), %polaczenie list
    sort(List, ListSorted), %posortowanie ktore rowniez usuwa duplikaty literalow
    %delNeg(ListSorted, ClList),%usuniecie wykluczajacych sie literalow
    list2kl(ListSorted,Resolvent). % zamiana listy na klauzule

% predykat resolve1 wykorzystywany w predykacie prove. Jest analogiczny
% do resolve z ta roznica ze dziala od razu na klauzulach w postaci
% list
resolve2(Var, Clause1, Clause2, Resolvent) :-
	delete(Clause1, Var, Res1),
	neg(Var, NegVar),
	delete(Clause2, NegVar, Res2),
	append(Res1, Res2, List),
	sort(List, Resolvent),
    check_negation(Resolvent). %jezeli klauzula zaweiera sprzeczne literaly to ja odrzucamy
    % \+ delNeg(ListSorted, Resolvent).%lub usuwamy sprzeczne literaly


return_pos_var(~H, H) :- !.
return_pos_var(H,H) :- !.


%sprawdza czy w klauzuli sa sprzeczne literaly np p v ~p
check_negation([]) :- !.
check_negation([Var | Vars]) :-
	neg(Var,NegVar),
	\+ member(NegVar, Vars),
	check_negation(Vars).

% inicjuje liste w ktorej bedzie trzymane nasze rozwiazanie, wrzuca do
% niej axionimy. Dodatkowo numeruje klauzule
initList(Clauses, AxiomList) :- initList(Clauses, AxiomList,1).
initList([],[],_).
initList([H|T],[(Clause, (axiom),Num) | Z],Num) :- 
	NewNum is Num + 1,
	kl2list(H,ClList),
    sort(ClList, ListSorted),
    list2kl(ListSorted, Clause), 
	initList(T, Z, NewNum).

%szuka par rezolwent i zmiennej po ktorej jest rezolewnta
findResolvent([Clause | Clauses], Clause, Resolvent, Var) :-
	resolventForVar(Clause, Clauses, Resolvent,Var).

findResolvent([ _ | Clauses], Res1, Res2, Var) :-
	findResolvent(Clauses, Res1, Res2, Var).

%szuka resolwenty dla kazdej zmiennej z klauzuli
resolventForVar([Var | _],[Clause |_],Clause, Var) :-
		neg(Var, NegElem),
		member(NegElem, Clause).

resolventForVar( [_ | Vars], Clauses, FirstClause, Var) :-
    resolventForVar(Vars, Clauses, FirstClause, Var).

resolventForVar([Var | Vars], [_ | Clauses ], Res,Var) :-
	resolventForVar([Var | Vars], Clauses, Res, Var).

%usuwa numery indeksow z dowodu
delIndex([],[]).
delIndex([(Clause, Poch, _) | T],[(Clause, Poch)| Steps]) :-
	delIndex(T,Steps).

%znajduje indeks klauzuli
findNum([(Clause,_,Nmbr) | _] ,Clause, Nmbr) :- !.
findNum([(_,_,_) | T] ,Clause, Nmbr) :- findNum(T, Clause, Nmbr).

prove(Clauses, Out) :-
	initList(Clauses, ListOfAxionim),
	tolist(Clauses, ClausesList), %zamiana listy klauzul na liste list
	length(ListOfAxionim,Num), %obliczenie indexu ostatniej klauzuli
	Index is Num + 1, %nr. od ktorego zaczynamy indeksowanie naszych klauzul
	prove(ClausesList, ListOfAxionim,Index,Proof),
	reverse(Proof, Proof1), %rozwiazanie bedzie w odwrotnej kolejnosci wiec je odwracamy
	delIndex(Proof1,Out), %usuniecie indeksow klauzul z listy
	!.

prove([[] | _], X,_,X).

prove([H | T], ListOfAxionim,Num,Proof) :-
	findResolvent([H | T], Res1, Res2, Var), %szukamy 2 klauzul w ktorych mozna zastosowac rezolucje
	resolve2(Var, Res1, Res2, Resolvent), %konstrukcja rezolwenty
	\+ member(Resolvent, [H|T]), %sprawdzenie czy rezolwenta juz nie zostala obliczona
	list2kl(Res1, Res1Cl),
	list2kl(Res2, Res2Cl),
	list2kl(Resolvent, ResolventCl), %zamiana list na klauzule
	findNum(ListOfAxionim,Res1Cl, Num1), %obliczenie indeksow klauzul z ktorych pochodzi rezolwenta
	findNum(ListOfAxionim,Res2Cl, Num2),
    return_pos_var(Var,PosVar),
	NewAx = [(ResolventCl, (PosVar,Num1,Num2),Num) | ListOfAxionim ], %dodanie rezolwenty do dowodu
	IncNum is Num + 1,
	prove([Resolvent, H | T], NewAx, IncNum,Proof).


