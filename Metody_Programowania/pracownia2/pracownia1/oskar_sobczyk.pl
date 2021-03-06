% Definiujemy modu� zawieraj�cy rozwi�zanie.
% Nale�y zmieni� nazw� modu�u na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} nale�y podstawi� odpowiednio swoje imi�
% i nazwisko bez znak�w diakrytycznych
:- module(oskar_sobczyk, [solve/2]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).


%predykat definiujacy funkcje boolowska
bool('t').
bool('f').


%predykat przeksztalcajacy klauzule na liste jej literalow
kl2list(H v T,[H|X]):-kl2list(T,X),!.
kl2list(X,[X]).

%predykat zamieniajacy liste klauzul na liste list
tolist([],[]).

tolist([H | T],[H1 | T1]):-
	kl2list(H,H1),
	tolist(T,T1).

%predykat usuwaj�cy negacje przed zmienna
delnegation([~Z|Zs],[Z|Ns]) :-
	delnegation(Zs,Ns), !.
delnegation([Z|Zs],[Z|Ns]) :-
        delnegation(Zs,Ns).
delnegation([],[]).

%predykat tworzy liste skladajaca sie z krotek (Zmienna, _)
varBoolList([Head0|Tail0],[(Head0,_)|Tail1]) :-
	varBoolList(Tail0,Tail1).
varBoolList([],[]).

%zwraca liste argumentow
argumentlist(Clauses, Odp) :-
		flatten(Clauses,X),
                delnegation(X,Xs),
		sort(Xs, Args),
                varBoolList(Args, Odp).

% predykat upraszczajacy liste klauzul wzgledem zmiennej Var. Jesli
% klauzula jest juz spelniona to ja pomija. Jesli natomiast klauzula nie
% jest spelniona wywola na niej predykat simplifyClause
simplify([Clause|Clauses],(Var,'t'), ClausesOut) :-
	member(Var,Clause),
	simplify(Clauses, (Var,'t'),ClausesOut),!.

simplify([Clause|Clauses], (Var,'f'), ClausesOut) :-
	member(~Var,Clause),
	simplify(Clauses, (Var,'f'), ClausesOut),!.

simplify([Clause|Clauses],(Var,Bool), [ClauseSimp|ClausesOut]) :-
	simplifyClause(Clause,(Var,Bool),ClauseSimp),
	simplify(Clauses, (Var,Bool),ClausesOut).

simplify([], (_,_),[]).

% predykat upraszcza klauzule wzgledem zmiennej Var - usuwa z niej
% zmienna Var
simplifyClause(Clause, (Var,'f'), ClauseOut) :-
	member(Var,Clause),
	delete(Clause,Var,ClauseOut),!.

simplifyClause(Clause, (Var,'t'), ClauseOut) :-
	member(~Var,Clause),
	delete(Clause,~Var,ClauseOut),!.

simplifyClause(Clause, (_,_), Clause).

% predykat zwraca liste zmiennych ktore wystepuja jako pojedyncze
% klauzule np. [p],[~q]
getSingleVars([[Var]|Clauses],[Var|Vars]) :-
	!,
	getSingleVars(Clauses,Vars).

getSingleVars([_|Clauses],Vars) :-
	getSingleVars(Clauses,Vars).

getSingleVars([],[]).

% predykat przyjmuje liste pojedynczych zmiennych, wartosciuje je a
% nastepnie upraszcza klauzule ktore zawiaraly te zmienne
removeSingleVar(Clauses, [~Var | Vars], VarsBool, ClausesOut) :-
	!,
	VarValue = (Var, 'f'),
	member(VarValue, VarsBool),
	simplify(Clauses,VarValue,ClausesSimp),
	removeSingleVar(ClausesSimp,Vars, VarsBool, ClausesOut).

removeSingleVar(Clauses, [Var | Vars], VarsBool, ClausesOut) :-
	!,
	VarValue = (Var, 't'),
	member(VarValue, VarsBool),
	simplify(Clauses, VarValue, ClausesSimp),
	removeSingleVar(ClausesSimp, Vars, VarsBool, ClausesOut).

removeSingleVar(Clauses, [],_,Clauses).


% Predykat zajmujacy sie wartosciowaniem zmiennych wystepujacych jako
% pojedyncze klauzule
evaluateSingleVars(Clauses,VarsBool,ClausesOut) :-
	getSingleVars(Clauses,Units),
	\+ [] = Units,
	!,
	removeSingleVar(Clauses,Units,VarsBool,Clauses2),
	evaluateSingleVars(Clauses2,VarsBool,ClausesOut).

evaluateSingleVars(Clauses, _, Clauses) :-!.

evaluateSingleVars(_,Clauses,Clauses) :-
	getSingleVars(Clauses,[]),!.



%predykat szukajacy wartosciowan
findEvaluation(Clauses, Arguments, ClausesOut) :-
	\+ member([],Clauses),
	[(Var,Val) | VarsBool] = Arguments,
	evaluateSingleVars(Clauses, Arguments, Clauses1),
	bool(Val),
	simplify(Clauses1, (Var, Val), Clauses2),
	findEvaluation(Clauses2, VarsBool, ClausesOut).


findEvaluation(Clauses, [], Clauses).

solve([],_) :- !, fail.

solve(Clauses, Solution) :-
         tolist(Clauses, Clist), %zamiana klauzul na liste
         argumentlist(Clist,Arguments), %stworzenie listy argumentow
	 findEvaluation(Clist, Arguments, []), %szukanie wartoscioan
	 Solution = Arguments.
