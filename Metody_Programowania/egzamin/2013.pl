p([a|_]).
p([_|X]):- p([a|X]).

p1(N):- N is 0.
p1(N):- p1(N-1).

append3(L1,L2,L3,W):-
    append(L1,L2,Lp),
    append(Lp,L3,W).

r(a).
r(b).
q(d).
p3(Y):-r(_),q(Y).
