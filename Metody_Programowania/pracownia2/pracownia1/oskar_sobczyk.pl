% Definiujemy modu� zawieraj�cy rozwi�zanie.
% Nale�y zmieni� nazw� modu�u na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} nale�y podstawi� odpowiednio swoje imi�
% i nazwisko bez znak�w diakrytycznych
%:- module(imie_nazwisko, [solve/2]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% G��wny predykat rozwi�zuj�cy zadanie.
% UWAGA: to nie jest jeszcze rozwi�zanie; nale�y zmieni� jego
% definicj�.
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


delnegation([~H|T], [H1|T1]) :-
		H1 = H, !.

delnegation([H|T], [H|T1]) :-



argumentlist(Clauses, Args) :-
		get_clauses_list(Clauses,List),
		flatten(List,X),
		sort(X, Args).



get_clauses_list([X], [L]) :-
		cl2set(X, L), !.
get_clauses_list([H|T], [H1|T1]) :-
		cl2set(H, H1), get_clauses_list(T, T1).

%solve(Clauses, Solution) :-


