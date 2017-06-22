empty([]).
p(X):- empty(X),!,append(X,X,X).
q(X):- !,append(X,X,X).

p2(X,X).
p2([H|T],X):- p2(T,[H|X]).

p3(p).
p3(X):- p3(p3(X)).
