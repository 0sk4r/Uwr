% Definiujemy modu³ zawieraj¹cy rozwi¹zanie.
% Nale¿y zmieniæ nazwê modu³u na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} nale¿y podstawiæ odpowiednio swoje imiê
% i nazwisko bez znaków diakrytycznych
%:- module(imie_nazwisko, [solve/2]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% G³ówny predykat rozwi¹zuj¹cy zadanie.
% UWAGA: to nie jest jeszcze rozwi¹zanie; nale¿y zmieniæ jego
% definicjê.
lsort([], []).
lsort([H|T],[H|R]) :-
        length(H, Lh),
        forall(member(M, T),
               (length(M, Lm),
                Lh =< Lm)),
        lsort(T, R), !.
lsort([F,S|T], R) :-
        append(T,[F],X),
        lsort([S|X], R).



lit(X) :-
		atom(X).
lit(~X) :-
		atom(X).


get_var(C v _, C) :-
		lit(C).


sel_alt(C v D, D) :-
		lit(C).


cl2set(X, L) :-
		cl2list(X, L1), sort(L1, L).

cl2list(X, [X]) :-
		lit(X), !.
cl2list(X, [H|T]) :-
		get_var(X, H), sel_alt(X, X1), cl2list(X1, T).



get_clauses_list([X], [L]) :-
		cl2set(X, L), !.
get_clauses_list([H|T], [H1|T1]) :-
		cl2set(H, H1), get_clauses_list(T, T1).

predykat(X,Y) :- get_clauses_list(X,Z),	lsort(Z,Y).

%solve(Clauses, Solution) :-


