% Definiujemy modu³ zawieraj¹cy rozwi¹zanie.
% Nale¿y zmieniæ nazwê modu³u na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} nale¿y podstawiæ odpowiednio swoje imiê
% i nazwisko bez wielkich liter oraz znaków diakrytycznych
%:- module(oskar_sobczyk, [resolve/4, prove/2]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Szukanie rezolwenty.
% UWAGA: to nie jest jeszcze rozwi¹zanie; nale¿y zmieniæ definicjê
% tego predykatu
%resolve(q, p v q, ~q v r, r v p).

% G³ówny predykat rozwi¹zuj¹cy zadanie.
% UWAGA: to nie jest jeszcze rozwi¹zanie; nale¿y zmieniæ jego
% definicjê.
prove(Clauses, Proof) :-
    Clauses = [p v q v ~r, ~p v q, r v q, ~q, p],
  Proof   = [(p v q v ~r, axiom), (~p v q, axiom), (q v ~r, (p, 1, 2)),
    (r v q, axiom), (q, (r, 4, 3)), (~q, axiom), ([], (q, 5, 6))].

%resolve(Var, PosClause, NegClause) :-


%predykat przeksztalcajacy klauzule na liste jej literalow
kl2list(H v T,[H|X]):-kl2list(T,X),!.
kl2list(X,[X]).

%predykat zamieniajacy liste klauzul na liste list
tolist([],[]).

tolist([H | T],[H1 | T1]):-
	kl2list(H,H1),
	tolist(T,T1).

%zamienia liste list na liste klauzul
list2kl([H | []],H).
list2kl([H | T],H v X):-list2kl(T,X),!.
list2kl([X],X).
list2kl([],[]) :- !.


%zamienia liste literalow na klauzule
toklauzule([],[]).

toklauzule([H | T],[H1 | T1]):-
	list2kl(H,H1),
	toklauzule(T,T1).


concatenate([], B, B):-!.
concatenate(A,[], A):-!.
concatenate(A v B, C, A v D):- !,concatenate(B, C, D).
concatenate(A, C, A v C).

remove(A,A,[]):-!.
remove(A, A v B, B):-!.
remove(A, B v A, B):-!.
remove(A, B v C, B v D) :- remove(A, C, D).

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

