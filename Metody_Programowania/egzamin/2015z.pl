%zadanie 2
p([],X,X).
p([H|T],X,Y):-
    p(T,[H|X],Y),!.

%zadanie 11
collect(N,N,[N]).
collect(N,M,[N|L]):-
    N1 is N+1,
    collect(N1,M,L).

