:- op(200, fx, ~).
:- op(500, xfy, v).

negacja(~ Literal,X):-
X = Literal, 
!.
negacja(Literal,X):-
X = ~Literal, 
!.

kl2list(H v T,[H|X]):-kl2list(T,X),!.
kl2list(X,[X]).

%sprawdza czy z dwoch klauzul mozna zrobic rezolwente
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

tolist([],[]).

tolist([H | T],[H1 | T1]):-
	kl2list(H,H1),
	tolist(T,T1).


szukaj([H | T], X):-
	szukaj(T,H,X).

szukaj([H|_],M,X):- rezolwenta(M,H,X).
szukaj([_|T],M,X):- szukaj(T,M,X).

prove(Klauzula,Dowod):- 
	tolist(Klauzula,Listaklauzul),
	prove(Klauzula,Listaklauzul,Listaklauzul).

prove(Klauzula,Dowod,Listaklauzul):-
	last(Listaklauzul,[]),
	Dowod = Listaklauzul,
	!.



prove(Klauzule,Dowod,[H | T]):-
	szukaj([H | T],Rezolwenty),
	append(Dowod,Rezolwenty,Dowod1),
	append(T, Rezolwenty, T1),
	prove(Klauzule,Dowod1,T1).

list2kl([H | T],H v X):-list2kl(T,X),!.
list2kl([X],X).

toklauzule([],[]).

toklauzule([H | T],[H1 | T1]):-
	list2kl(H,H1),
	toklauzule(T,T1).





%zamiana klauzuli na lista
%prove([[~p,q],[~p,~r,s],[~q,r],[p],[~s]],X).
%tolist([~p v q, ~p v ~r v s, ~q v r, p, s],X).
% prove([~p v q,~p v ~r v ~s,~q v r, p, ~s],X).

