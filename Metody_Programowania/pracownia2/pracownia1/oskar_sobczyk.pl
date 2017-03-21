% Definiujemy moduï¿½ zawierajï¿½cy rozwiï¿½zanie.
% Naleï¿½y zmieniï¿½ nazwï¿½ moduï¿½u na {imie}_{nazwisko} gdzie za
% {imie} i {nazwisko} naleï¿½y podstawiï¿½ odpowiednio swoje imiï¿½
% i nazwisko bez znakï¿½w diakrytycznych
%:- module(imie_nazwisko, [solve/2]).

% definiujemy operatory ~/1 oraz v/2
:- op(200, fx, ~).
:- op(500, xfy, v).

% Gï¿½ï¿½wny predykat rozwiï¿½zujï¿½cy zadanie.
% UWAGA: to nie jest jeszcze rozwiï¿½zanie; naleï¿½y zmieniï¿½ jego
% definicjï¿½.



%predykat przeksztalcajacy klauzule na liste jej literalow
kl2list(H v T,[H|X]):-kl2list(T,X),!.
kl2list(X,[X]).

%predykat zamieniajacy liste klauzul na liste list
tolist([],[]).

tolist([H | T],[H1 | T1]):-
	kl2list(H,H1),
	tolist(T,T1).

%predykat usuwaj¹cy negacje przed zmienna
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

% predykat upraszczajacy klauzule. Jesli klauzula jest juz spelniona to
% ja pomija. Jesli natomiast klauzula nie jest spelniona wywola na niej
% predykat simplifyClause
simplify((Var,'t'),[Line0|Lines0], Lines1) :-
    member(Var,Line0),
    simplify((Var,'t'),Lines0,Lines1),!.

simplify((Var,'f'),[Line0|Lines0], Lines1) :-
    member(~Var,Line0),
    simplify((Var,'f'),Lines0,Lines1),!.

simplify((Var,Value),[Line0|Lines0], [Line1|Lines1]) :-
    simplifyClause((Var,Value),Line0,Line1),
    simplify((Var,Value),Lines0,Lines1).

simplify((_,_),[],[]).

%predykat upraszcza klauzule - usuwa z niej juz zwartosciowane zmienne
simplifyClause((Var,'f'),Line0,Line1) :-
    member(Var,Line0),
    subtract(Line0,[Var],Line1),!.

simplifyClause((Var,'t'),Line0,Line1) :-
    member(~Var,Line0),
    subtract(Line0,[~Var],Line1),!.

simplifyClause((Var,_),Line0,Line0).
%    \+ member(Var,Line0),
%    \+ member(~Var,Line0).

% predykat zwraca liste zmiennych ktore wystepuja jako pojedyncze
% klauzule
getSingleVars([[Unit]|Lines],[Unit|Units]) :-
    getSingleVars(Lines,Units).

getSingleVars([Line|Lines],Units) :-
    dif(Line,[_]),
    getSingleVars(Lines,Units).

getSingleVars([],[]).

% predykat przyjmuje liste pojedynczych zmiennych, wartosciuje je a
% nastepnie upraszcza klauzule ktore zawiaraly te zmienne
removeSingleVar([~Var | Vars], VarValues, Dimac0, Dimac1) :-
	!,VarValue = (Var, 'f'),
	member(VarValue, VarValues),
	simplify(VarValue, Dimac0, IDimac1),
	removeSingleVar(Vars, VarValues, IDimac1, Dimac1).

removeSingleVar([Var | Vars], VarValues, Dimac0, Dimac1) :-
	!,VarValue = (Var, 't'),
	member(VarValue, VarValues),
	simplify(VarValue, Dimac0, IDimac1),
	removeSingleVar(Vars, VarValues, IDimac1, Dimac1).

removeSingleVar([],_,Dimac0,Dimac0).


% Predykat zajmujacy sie wartosciowaniem zmiennych wystepujacych jako
% pojedyncze klauzule
evaluateSingleVars(VarValues,Dimac0,Dimac1) :-
    getSingleVars(Dimac0,Units),
    (dif(Units,[]) ->
        !,
        removeSingleVar(Units,VarValues,Dimac0,IDimac1),
        evaluateSingleVars(VarValues,IDimac1,Dimac1)
    ; !, Dimac0 = Dimac1
    ).

evaluateSingleVars(_,Dimac0,Dimac0) :-
    getSingleVars(Dimac0,[]).


solve([],_) :- !, fail.

solve(Clauses, Solution) :-
         tolist(Clauses, Clist),
         argumentlist(Clist,Arguments),
	 solve(Clist, Arguments, []),
	 Solution = Arguments.

solve(Clauses, Arguments, ClausesOut) :-
	\+ member([],Clauses),
	Arguments = [(Var,Val) | VarsBool],
	evaluateSingleVars(Arguments, Clauses, Clauses1),
	bool(Val),
	simplify((Var, Val),Clauses1, Clauses2),
	solve(Clauses2, VarsBool, ClausesOut).


solve(Clauses, [], Clauses).

bool('t').
bool('f').

