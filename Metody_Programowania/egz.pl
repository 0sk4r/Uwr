%Zadania z egzaminu MP PROLOG
p([],X,X).
p([H|Y],X,Y):- p(T,[H|X],Y),!.

collect(N,N,[N]).
collect(N,M,[N|L]):- N1 is N+1, collect(N1,M,L).

combine([],X,[],X).
combine([A|TA],X,[A,B|R],TB):-
    combine(TA,X,R,[B|TB]).

p2(0).
p2(N) :- M is N+1, p2(M).

from(N,N).
from(N,M):- N1 is N+1, from(N1,M).

max(X,Y,Y):- Y>X,!.
max(X,_,X).

len([],0).
len([_|T],N+1):- len(T,N).

x(0) --> "".
x(N+1) --> "a",x(N), "a".

p1(X,X).
p1(X,[a|Y]):- p1([b|X],Y).

p3([a|_]).
p3([_|X]):- p3([a|X]).

p4(a).
p4(f(X,Y)):-p4(X),p4(Y).

%f(a,a).
%f(b,b).

p5([]).
p5([a|X]) :- p5(X),!.

p6(N) :- N is 0.
p6(N) :- p6(N-1).

append3(L1,L2,L3,W):- append(L1,L2,Lp), append(Lp,L3,W).

r(a).
r(b).
q(d).
p7(Y) :- r(_),q(Y).

take(N,[H|T],[H|S]):-
    N>0,
    N1 is N-1,
    take(N1,T,S).
take(0,_,[]).

repeat(N,E,X):-
    L=[E|L],
    take(N,L,X).

q2016(0).
q2016(X+1):- q2016(X).

r2016([]).
r2016([H|T]):- q2016(H), r2016(T).
