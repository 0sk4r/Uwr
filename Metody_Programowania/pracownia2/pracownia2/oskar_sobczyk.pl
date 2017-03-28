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

neg(~A, A):-!.
neg(A, ~A).

delNeg([], []) :- !.

delNeg([Var | T],Out) :-
	neg(Var, NegVar),
	member(NegVar, T),
	!,
	delete(T, NegVar, T1),
	delNeg(T1, Out).

delNeg([Var | T], [Var | T1]) :-
	delNeg(T,T1).

resolve(Var, PosClause, NegClause, Resolvent):-
    kl2list(PosClause, PosList),
    kl2list(NegClause, NegList),
    delete(PosList,Var, Res1),
    neg(Var,NegVar),
    delete(NegList, NegVar, Res2),
    append(Res1, Res2, List),
    sort(List, ListSorted),
    delNeg(ListSorted, ClList),
    list2kl(ClList,Resolvent).

resolve2(Var, Clause1, Clause2, Resolvent) :-
	delete(Clause1, Var, Res1),
	delete(Clause2, Var, Res2),
	neg(Var, NegVar),
	delete(Res1, NegVar, Res3),
	delete(Res2, NegVar, Res4),
	append(Res3, Res4, List),
	sort(List, ListSorted),
	delNeg(ListSorted, Resolvent).




%tworzy liste axionimow
initList(Clauses, ListOfAxionim) :-
		initList(Clauses, ListOfAxionim, [],1).

initList([], ListOfAxionim, ListOfAxionim,Num) :- !.
initList([H|T], ListOfAxionim, Acc,Num) :-
	NewNum is Num + 1,
		initList(T, ListOfAxionim, [(H, (axiom), Num) | Acc],NewNum).

prove(Clauses, Out) :-
	initList(Clauses, ListOfAxionim),
	tolist(Clauses, ClausesList),
	length(ListOfAxionim,Num),
	Index is Num + 1,
	prove(ClausesList, ListOfAxionim,Index, Proof),
	reverse(Proof, Proof1),
	writeProof(Proof1,Out),
	write(Out),!.

prove([[] | _], X,_, X).

prove([H | T], ListOfAxionim,Num,Proof) :-
	findResolvent([H | T], Res1, Res2, Var),
	resolve2(Var, Res1, Res2, Resolvent),
	\+ member(Resolvent, [H|T]),
	list2kl(Res1, Res1Cl),
	list2kl(Res2, Res2Cl),
	list2kl(Resolvent, ResolventCl),
	findNum(ListOfAxionim,Res1Cl, Num1),
	findNum(ListOfAxionim,Res2Cl, Num2),
	NewAx = [(ResolventCl, (Var,Num1,Num2),Num) | ListOfAxionim ],
	NewNum is Num + 1,
	prove([Resolvent , H | T], NewAx, NewNum, Proof).


%szuka resolwent po zmiennej Var
resolventForVar([Var | _],[Clause |Clauses],Clause, Var) :-
		neg(Var, NegElem),
		%for(Clauses, FirstClause, _),
		member(NegElem, Clause).
resolventForVar([Var | Vars], [_ | Clauses ], Res,Var) :-
	resolventForVar([Var | Vars], Clauses, Res, Var).

resolventForVar([_ | Vars], Clauses, FirstClause, Var) :-
	resolventForVar(Vars, Clauses, FirstClause, Var).


%znajduje kolejne rezolwenty dla kolejnych klauzul
findResolvent([Clause | Clauses], Clause, Resolvent, Var) :-
	resolventForVar(Clause, Clauses, Resolvent,Var).

findResolvent([ _ | Clauses], Res1, Res2, Var) :-
	findResolvent(Clauses, Res1, Res2, Var).


%znajduje numer klauzuli
findNum([(Clause,_,Nmbr) | T] ,Clause, Nmbr) :- !.
findNum([(_,_,_) | T] ,Clause, Nmbr) :- findNum(T, Clause, Nmbr).

writeProof([],[]).
writeProof([(Clause, Poch, _) | T],[(Clause, (Poch))| Steps]) :-
	writeProof(T,Steps).


