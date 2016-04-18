:- op(200, fx, ~).
:- op(500, xfy, v).

negacja(~ Literal,X):-
X = Literal, 
!.
negacja(Literal,X):-
X = ~Literal, 
!.

%sprawdza czy literal wystepuje w klauzuli
wklauzuli(X, X v _):- !.
wklauzuli(X, _ v T):-
wklauzuli(X,T).
wklauzuli(X,X):- !.

usun(A, A v B, B).
usun(A, B v A, B).
usun(A, B v C v D, B v E):-
usun(A, C v D, E).
usun(X,X,).

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
rezolwenta(Acc1,Acc2, Klauzula1, Klauzula2, Rezolwenta).

rezolwenta(Acc1,Acc2,Literal, Klauzula2,Rezolwenta):-
negacja(Literal,Nliteral),
member(Nliteral,Klauzula2),
delete(Acc1,Literal,Lista1),
delete(Acc2,Nliteral,Lista2),
append(Lista1,Lista2,Rezolwenta).

prove([H | T], X):-
prove(T,H,X).

prove([H|_],M,X):- rezolwenta(M,H,X).
prove([_|T],M,X):- prove(T,M,X).

%zamiana klauzuli na lista

a b c d